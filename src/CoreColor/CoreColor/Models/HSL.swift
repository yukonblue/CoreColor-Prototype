//
//  HSL.swift
//  CoreColor
//
//  Created by x on 10/15/2022.
//

import Foundation

protocol HueColor: Color {

    ///
    /// The hue, as degrees in the range `[0, 360)`
    ///
    var h: Float { get }
}

extension HueColor {

    func hueOr(_ n: Float) -> Float {
        guard !h.isNaN else {
            return n
        }
        return h
    }
}

/**
 * A color model represented with Hue, Saturation, and Lightness.
 *
 * This is a cylindrical representation of the sRGB space used in [RGB].
 *
 * | Component  | Description                               | Range      |
 * | ---------- | ----------------------------------------- | ---------- |
 * | [h]        | hue, degrees, `NaN` for monochrome colors | `[0, 360)` |
 * | [s]        | saturation                                | `[0, 1]`   |
 * | [l]        | lightness                                 | `[0, 1]`   |
 */

extension FloatingPoint {

    /// https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.ranges/coerce-at-least.html
    func coerceAtLeast(minimumValue: Self) -> Self {
        max(self, minimumValue)
    }
}

struct HSL: HueColor {

    let h: Float
    let s: Float
    let l: Float
    let alpha: Float

    let space: ColorSpace

    func toSRGB() -> RGB {
        guard s >= 1e-7 else {
            return RGB(r: self.l, g: self.l, b: self.l, alpha: self.alpha, space: RGBColorSpaces.sRGB)
        }

        let hD = Double(hueOr(0)).normalizeDeg / 30.0
        let sD = Double(s)
        let lD = Double(l)

        func f(nD: Double) -> Float {
            let kD = (nD + hD).truncatingRemainder(dividingBy: 12.0)
            let aD = sD * min(lD, 1.0 - lD)
            return Float((lD - aD * min(kD - 3.0, 9.0 - kD, 1.0).coerceAtLeast(minimumValue: -1.0)))
        }

//        return RGBColorSpaces.sRGB
        fatalError("TODO")
    }
}