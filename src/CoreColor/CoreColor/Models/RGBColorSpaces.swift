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
}

struct RGBColorSpaceImpl: RGBColorSpace {
    
    var matrixToXyz: matrix_float3x3 {
        //        rgbToXyzMatrix(whitePoint, r, g, b)
        fatalError("TODO")
    }

    var matrixFromXyz: matrix_float3x3 {
        matrixToXyz.inverse
    }

    let components: [ColorComponentInfo] = rectangularComponentInfo(names: ["RGB"])

    let name: String
    let whitePoint: WhitePoint
    let transferFunctions: RGBTransferFunctions
    let r: xyY
    let g: xyY
    let b: xyY
}
