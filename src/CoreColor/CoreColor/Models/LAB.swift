//
//  LAB.swift
//  CoreColor
//
//  Created by x on 10/15/2022.
//

import Foundation

// http://www.brucelindbloom.com/index.html?LContinuity.html

/** ϵ = (6/29)^3 */
fileprivate let CIE_E: Float = 216.0 / 24389.0

/** κ = (29/3)^3 */
fileprivate let CIE_K: Float = 24389.0 / 27.0

/** ϵ × κ */
fileprivate let CIE_E_times_K: Float = 8.0

protocol LABColorSpace: WhitePointColorSpace {

    init(whitePoint: WhitePoint)
}

struct LABColorSpaceImpl: LABColorSpace {

    let whitePoint: WhitePoint

//    init(whitePoint: WhitePoint) {
//        self.whitePoint = whitePoint
//    }

    let name: String = "LAB"

    let components: [ColorComponentInfo] = rectangularComponentInfo(name: "LAB")
}

enum LABColorSpaces {

    ///
    /// An [LAB] color space calculated relative to [Illuminant.D50]
    ///
    static let LAB50: LABColorSpace = LABColorSpaceImpl(whitePoint: Illuminant.D50)

    ///
    /// An [LAB] color space calculated relative to [Illuminant.D65]
    ///
    static let LAB65: LABColorSpace = LABColorSpaceImpl(whitePoint: Illuminant.D65)
}

/**
 * CIE LAB color space, also referred to as `CIE 1976 L*a*b*`.
 *
 * The cylindrical representation of this space is [LCHab].
 *
 * [LAB] is calculated relative to a [given][space] [whitePoint], which defaults to [Illuminant.D65].
 *
 * | Component  | Description | Range         |
 * | ---------- | ----------- | ------------- |
 * | [l]        | lightness   | `[0, 100]`    |
 * | [a]        | green-red   | `[-100, 100]` |
 * | [b]        | blue-yellow | `[-100, 100]` |
 */
struct LAB: Color {

    let l: Float
    let a: Float
    let b: Float

    func toSRGB() -> RGB {
        switch l {
        case 0.0:
            return RGB(r: 0.0, g: 0.0, b: 0.0, alpha: self.alpha, space: RGBColorSpaces.sRGB)
        default:
            return self.toXYZ().toSRGB()
        }
    }

    func toXYZ() -> XYZ {
        // http://www.brucelindbloom.com/Eqn_Lab_to_XYZ.html
        guard let labColorSpace = self.space as? LABColorSpace else {
            fatalError("TODO")
        }
        let xyzSpace = XYZColorSpaceImpl(whitePoint: labColorSpace.whitePoint)
        guard self.l != 0.0 else {
//            return xyzSpace(0.0, 0.0, 0.0)
            fatalError("TODO")
        }

        let fy = (l + 16) / 116.0
        let fz = fy - b / 200.0
        let fx = a / 500.0 + fy

        let yr = l > CIE_E_times_K ? pow(fy, 3.0) : l / CIE_K
        let it = pow(fz, 3.0)
        let zr = (it > CIE_E) ? it : (116 * fz - 16) / CIE_K
        let it2 = pow(fx, 3.0)
        let xr = (it2 > CIE_E) ? it2 : (116 * fx - 16) / CIE_K

        let wp = labColorSpace.whitePoint.chromaticity
//        return xyzSpace(xr * wp.X, yr * wp.Y, zr * wp.Z, alpha)
        fatalError("TODO")
    }

    let alpha: Float

    let space: ColorSpace
}
