//
//  RGBColorSpaces.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation
import simd

fileprivate let SRGB_R = xyY(x: 0.6400, y: 0.3300)

fileprivate let SRGB_G = xyY(x: 0.3000, y: 0.6000)

fileprivate let SRGB_B = xyY(x: 0.1500, y: 0.0600)

enum RGBColorSpaces {

    ///
    /// sRGB color space
    ///
    /// ### References
    /// - [IEC 61966-2-1](https://webstore.iec.ch/publication/6169)
    ///
    static let sRGB: RGBColorSpace = RGBColorSpaceImpl(
        name: "sRGB",
        whitePoint: Illuminant.D65,
        transferFunctions: SRGBTransferFunctions(),
        r: SRGB_R,
        g: SRGB_G,
        b: SRGB_B
    )

    ///
    /// Linear sRGB color space
    ///
    /// ### References
    /// - [IEC 61966-2-1](https://webstore.iec.ch/publication/6169)
    ///
    static let LinearSRGB: RGBColorSpace = RGBColorSpaceImpl(
        name: "Linear sRGB",
        whitePoint: Illuminant.D65,
        transferFunctions: LinearTransferFunctions(),
        r: SRGB_R,
        g: SRGB_G,
        b: SRGB_B
    )

    ///
    /// Adobe RGB 1998 color space
    ///
    /// The CSS Color Module 4 calls this space `a98-rgb`.
    ///
    /// ### References
    /// - [Adobe RGB (1998) Color Image Encoding](https://www.adobe.com/digitalimag/pdfs/AdobeRGB1998.pdf)
    ///
    static let AdobeRGB: RGBColorSpace = RGBColorSpaceImpl(
        name: "Adobe RGB",
        whitePoint: Illuminant.D65,
        transferFunctions: GammaTransferFunctions(gamma: 2.19921875),
        r: xyY(x: 0.64, y: 0.33),
        g: xyY(x: 0.21, y: 0.71),
        b: xyY(x: 0.15, y: 0.06)
    )

    /**
     * Display P3 color space
     *
     * The CSS Color Module 4 calls this space `display-p3`.
     *
     * ### References
     * - [Apple](https://developer.apple.com/documentation/coregraphics/cgcolorspace/1408916-displayp3)
     * - [RP 431-2:2011](https://ieeexplore.ieee.org/document/7290729)
     * - [Digital Cinema System Specification - Version 1.1](https://www.dcimovies.com/archives/spec_v1_1/DCI_DCinema_System_Spec_v1_1.pdf)
     */
    static let DisplayP3: RGBColorSpace = RGBColorSpaceImpl(
        name: "Display P3",
        whitePoint: Illuminant.D65,
        transferFunctions: SRGBTransferFunctions(),
        r: xyY(x: 0.680, y: 0.320),
        g: xyY(x: 0.265, y: 0.690),
        b: xyY(x: 0.150, y: 0.060)
    )
}

// TODO: Decide value-reference semantics on this
class RGBColorSpaceImpl: RGBColorSpace {

    init(name: String, whitePoint: WhitePoint, transferFunctions: RGBTransferFunctions, r: xyY, g: xyY, b: xyY) {
        self.name = name
        self.whitePoint = whitePoint
        self.transferFunctions = transferFunctions
        self.r = r
        self.g = g
        self.b = b
    }

    var matrixToXyz: matrix_float3x3 {
        rgbToXyzMatrix(whitePoint: whitePoint, r: r, g: g, b: b)
    }

    var matrixFromXyz: matrix_float3x3 {
        matrixToXyz.inverse
    }

    let components: [ColorComponentInfo] = rectangularComponentInfo(name: "RGB")

    let name: String
    let whitePoint: WhitePoint
    let transferFunctions: RGBTransferFunctions
    
    let r: xyY
    let g: xyY
    let b: xyY
}

// [SMPTE RP 177-1993](http://car.france3.mars.free.fr/Formation%20INA%20HD/HDTV/HDTV%20%202007%20v35/SMPTE%20normes%20et%20confs/rp177.pdf)
private func rgbToXyzMatrix(whitePoint: WhitePoint, r: xyY, g: xyY, b: xyY) -> matrix_float3x3 {
    /**
     primaries = Matrix(
             r.x, g.x, b.x,
             r.y, g.y, b.y,
             r.z, g.z, b.z,
         )
     */

    let primaries = matrix_float3x3(columns: (simd_float3(x: r.x, y: r.y, z: r.z),
                                              simd_float3(x: g.x, y: g.y, z: g.z),
                                              simd_float3(x: b.x, y: b.y, z: b.z)))

    let wp = whitePoint.chromaticity

    let CP = primaries.inverse * simd_float3(x: wp.X, y: wp.Y, z: wp.Z)

    return primaries * matrix_float3x3(diagonal: SIMD3<Float>(CP.x, CP.y, CP.z))
}
