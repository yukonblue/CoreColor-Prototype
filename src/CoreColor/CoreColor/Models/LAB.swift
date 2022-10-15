//
//  LAB.swift
//  CoreColor
//
//  Created by x on 10/15/2022.
//

import Foundation

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
        fatalError("TODO")
    }

    let alpha: Float

    let space: ColorSpace
}
