//
//  RGBColorSpaces.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

let SRGB_R = xyY(x: 0.6400, y: 0.3300)

let SRGB_G = xyY(x: 0.3000, y: 0.6000)

let SRGB_B = xyY(x: 0.1500, y: 0.0600)

//enum RGBColorSpaces {
//
//    ///
//    /// sRGB color space
//    ///
//    /// ### References
//    /// - [IEC 61966-2-1](https://webstore.iec.ch/publication/6169)
//    ///
//    static let sRGB: RGBColorSpace = com.github.ajalt.colormath.model.SRGB
//
//    ///
//    /// Linear sRGB color space
//    ///
//    /// ### References
//    /// - [IEC 61966-2-1](https://webstore.iec.ch/publication/6169)
//    ///
//    static let LinearSRGB: RGBColorSpace = RGBColorSpace(
//            "Linear sRGB",
//            Illuminant.D65,
//            RGBColorSpace.LinearTransferFunctions,
//            SRGB_R,
//            SRGB_G,
//            SRGB_B,
//        )
//
//    ///
//    /// Adobe RGB 1998 color space
//    ///
//    /// The CSS Color Module 4 calls this space `a98-rgb`.
//    ///
//    /// ### References
//    /// - [Adobe RGB (1998) Color Image Encoding](https://www.adobe.com/digitalimag/pdfs/AdobeRGB1998.pdf)
//    ///
//    static let AdobeRGB: RGBColorSpace = RGBColorSpace(
//            "Adobe RGB",
//            Illuminant.D65,
//            RGBColorSpace.GammaTransferFunctions(2.19921875),
//            xyY(0.64, 0.33),
//            xyY(0.21, 0.71),
//            xyY(0.15, 0.06),
//        )
//
//    
//}
