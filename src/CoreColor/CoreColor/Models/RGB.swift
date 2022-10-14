//
//  RGB.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

/// The RGB color model, using the [sRGB][SRGB] color space by default.

struct RGB: Color {

    let r: Float
    let g: Float
    let b: Float
    let alpha: Float
//    let space: RGBColorSpace
    let space: ColorSpace

    ///
    /// The red channel scaled to [0, 255].
    ///
    var redInt: Int {
        Int(r * 255)
    }

    ///
    /// The green channel scaled to [0, 255].
    ///
    var greenInt: Int {
        Int(g * 255)
    }

    ///
    /// The blue channel scaled to [0, 255]. HDR colors may exceed this range.
    ///
    var blueInt: Int {
        Int(b * 255)
    }

    ///
    /// The alpha channel scaled to [0, 255]. If the alpha is undefined, 255 will be returned.
    ///
    var alphaInt: Int {
        Int(alpha * 255)
    }

    func toSRGB() -> RGB {
        fatalError("")
    }
}
