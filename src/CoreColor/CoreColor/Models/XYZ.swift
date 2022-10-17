//
//  XYZ.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation
import simd

/**
The CIECAM02 transform matrix for XYZ -> LMS
 
https://en.wikipedia.org/wiki/CIECAM02#CAT02
 
Matrix(
     +0.7328f, +0.4296f, -0.1624f,
     -0.7036f, +1.6975f, +0.0061f,
     +0.0030f, +0.0136f, +0.9834f,
)
 */
fileprivate let CAT02_XYZ_TO_LMS = matrix_float3x3(columns: (
    simd_float3(+0.7328, -0.7036, +0.0030),
    simd_float3(+0.4296, +1.6975, +0.0136),
    simd_float3(-0.1624, +0.0061, +0.9834)
))

fileprivate let CAT02_LMS_TO_XYZ = CAT02_XYZ_TO_LMS.inverse

internal func rectangularComponentInfo(name: String) -> [ColorComponentInfo] {
    Array(name).map { ColorComponentInfo(name: String($0), isPolar: false) } + [ColorComponentInfo(name: "alpha", isPolar: false)]
}

protocol XYZColorSpace: WhitePointColorSpace {

    func createModel(x: Float, y: Float, z: Float, alpha: Float) -> XYZ

    func chromaticAdaptationMatrix(for srcWp: xyY, xyzToLms: matrix_float3x3, lmsToXyz: matrix_float3x3) -> matrix_float3x3
}

extension XYZColorSpace {

    func createModel(x: Float, y: Float, z: Float, alpha: Float = 1.0) -> XYZ {
        XYZ(x: x, y: y, z:z, alpha: alpha, space: self)
    }

    func chromaticAdaptationMatrix(for srcWp: xyY, xyzToLms: matrix_float3x3 = CAT02_XYZ_TO_LMS, lmsToXyz: matrix_float3x3 = CAT02_LMS_TO_XYZ) -> matrix_float3x3 {
        let dstWp = self.whitePoint.chromaticity
        
        let src = xyzToLms * simd_float3(x: srcWp.X, y: srcWp.Y, z: srcWp.Z)
        let dst = xyzToLms * simd_float3(x: dstWp.X, y: dstWp.Y, z: dstWp.Z)

        return lmsToXyz * simd_float3x3(diagonal: SIMD3<Float>(dst.x / src.x, dst.y / src.y, dst.z / src.z)) * xyzToLms
    }
}

enum XYZColorSpaces {

    ///
    /// An [XYZ] color space calculated relative to [Illuminant.D65]
    ///
    static let XYZ65: XYZColorSpace = XYZColorSpaceImpl(whitePoint: Illuminant.D65)

    ///
    /// An [XYZ] color space calculated relative to [Illuminant.D50]
    ///
    static let XYZ50: XYZColorSpace = XYZColorSpaceImpl(whitePoint: Illuminant.D50)
}

struct XYZColorSpaceImpl: XYZColorSpace {

    let whitePoint: WhitePoint

    let name = "XYZ"

    let components = rectangularComponentInfo(name: "XYZ")

    
}

///
/// The CIEXYZ color model
///
/// [XYZ] is calculated relative to a [given][space] [whitePoint], which defaults to [Illuminant.D65].
///
/// | Component  | Range       |
/// | -------------- | -------------|
/// | [x]              | `[0, 1]` |
/// | [y]              | `[0, 1]` |
/// | [z]              | `[0, 1]` |
struct XYZ: Color {
    func toSRGB() -> RGB {
        to(rgbSpace: RGBColorSpaces.sRGB)
    }

    private func to(rgbSpace: RGBColorSpace) -> RGB {
        let xyz = adapt(toSpace: XYZColorSpaceImpl(whitePoint: rgbSpace.whitePoint))
        let xyz_v3 = simd_float3(x: xyz.x, y: xyz.y, z: xyz.z)

        let f = rgbSpace.transferFunctions.oetf

        let v = rgbSpace.matrixFromXyz * xyz_v3

        return RGB(r: f(v.x), g: f(v.y), b: f(v.z), alpha: self.alpha, space: rgbSpace)
    }

    let x: Float
    let y: Float
    let z: Float
    let alpha: Float
//    let space: XYZColorSpace
    let space: ColorSpace

    func adapt(toSpace space: XYZColorSpace) -> XYZ {
        adaptToM(space: space, m: CAT02_XYZ_TO_LMS, mi: CAT02_LMS_TO_XYZ)
    }

    private func adaptToM(space: XYZColorSpace, m: matrix_float3x3, mi: matrix_float3x3) -> XYZ {
        guard let xyzSpace = self.space as? XYZColorSpace else {
            fatalError("")
        }
//        guard xyzSpace.whitePoint != space.whitePoint else {
//            return self
//        }

        let transform = xyzSpace.chromaticAdaptationMatrix(for: xyzSpace.whitePoint.chromaticity, xyzToLms: m, lmsToXyz: mi)
//        transform
        
        let v = transform * simd_float3(x: self.x, y: self.y, z: self.z)

        return XYZ(x: v.x, y: v.y, z: v.z, alpha: self.alpha, space: self.space)
    }
}

extension XYZ {

    func toLAB() -> LAB {
        func f(_ t: Float) -> Float {
            t > CIE_E ? (cbrt(t)) : ((t * CIE_K + 16) / 116)
        }

        guard let xyzColorSpace = space as? XYZColorSpace else {
            fatalError("")
        }

        let fx = f(x / xyzColorSpace.whitePoint.chromaticity.X)
        let fy = f(y / xyzColorSpace.whitePoint.chromaticity.Y)
        let fz = f(z / xyzColorSpace.whitePoint.chromaticity.Z)

        let l = (116 * fy) - 16
        let a = 500 * (fx - fy)
        let b = 200 * (fy - fz)

        return LAB(l: l, a: a, b: b, alpha: self.alpha, space: LABColorSpaceImpl(whitePoint: xyzColorSpace.whitePoint))
    }
}
