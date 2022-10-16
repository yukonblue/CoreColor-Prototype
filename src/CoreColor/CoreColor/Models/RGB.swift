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

extension RGB {

    func toHSL() -> HSL {
        fatalError("To be implemented ...")
    }

    func toHSV() -> HSV {
        fatalError("To be implemented ...")
    }

    func toXYZ() -> XYZ {
        fatalError("To be implemented ...")
    }

    func toCMYK() -> CMYK {
        fatalError("To be implemented ...")
    }
}

extension Double {

    var normalizeDeg: Double {
        (self.truncatingRemainder(dividingBy: 360.0) + 360.0).truncatingRemainder(dividingBy: 360.0)
    }
}

extension RGB {

    ///
    /// Call [block] with the hue, min of color channels, max of color channels, and the
    /// delta between min and max.
    ///
    /// Min and max are scaled to [0, 1]
    ///
    func srgbHueMinMaxChroma<T>(_ block: (_ hue: Double, _ min: Double, _ max: Double, _ chroma: Double) -> T) -> T {
        let rD: Double = Double(self.r)
        let gD: Double = Double(self.g)
        let bD: Double = Double(self.b)

        let minD = min(rD, gD, bD)
        let maxD = max(rD, gD, bD)
        let chroma = maxD - minD

        let h: Double = {
            if chroma < 1e-7 {
                return Double.nan
            } else if rD == maxD {
                return (gD - bD) / chroma
            } else if gD == maxD {
                return 2 + (bD - rD) / chroma
            } else if bD == maxD {
                return 4 + (rD - gD) / chroma
            } else {
                return 0.0
            }
        }() * 60

        return block(h.normalizeDeg, minD, maxD, chroma)
    }
}
