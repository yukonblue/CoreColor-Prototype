//
//  CMYK.swift
//  CoreColor
//
//  Created by x on 10/15/2022.
//

import Foundation

/**
 * A color in the CMYK (cyan, magenta, yellow, and key) color model.
 *
 * Conversions to and from this model use the device-independent ("naive") formulas.
 *
 * | Component  | Description | Range    |
 * | ---------- | ----------- | -------- |
 * | [c]        | cyan        | `[0, 1]` |
 * | [m]        | magenta     | `[0, 1]` |
 * | [y]        | yellow      | `[0, 1]` |
 * | [k]        | key / black | `[0, 1]` |
 */
struct CMYK: Color {

    let c: Float
    let m: Float
    let y: Float
    let k: Float
    let alpha: Float

    var space: ColorSpace {
        Self.colorspace
    }

    func toSRGB() -> RGB {
        let r = (1 - c) * (1 - k)
        let g = (1 - m) * (1 - k)
        let b = (1 - y) * (1 - k)
        return RGB(r: r, g: g, b: b, alpha: alpha, space: RGBColorSpaces.sRGB)
    }
}

struct CMYKColorSpace: ColorSpace {

    let name = "CMYK"

    let components: [ColorComponentInfo] = rectangularComponentInfo(names: ["CMYK"])
}

extension CMYK {

    static let colorspace: ColorSpace = CMYKColorSpace()
}