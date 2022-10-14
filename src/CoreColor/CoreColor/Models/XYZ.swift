//
//  XYZ.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

internal func rectangularComponentInfo(names: [String]) -> [ColorComponentInfo] {
    (names + ["alpha"]).map { name in ColorComponentInfo(name: name, isPolar: false) }
}

protocol XYZColorSpace: WhitePointColorSpace {

    func createModel(x: Float, y: Float, z: Float, alpha: Float) -> XYZ
}

extension XYZColorSpace {

    func createModel(x: Float, y: Float, z: Float, alpha: Float = 1.0) -> XYZ {
        XYZ(x: x, y: y, z:z, alpha: alpha, space: self)
    }
}

struct XYZColorSpaceImpl: XYZColorSpace {

    let whitePoint: WhitePoint

    let name = "XYZ"

    let components = rectangularComponentInfo(names: ["XYZ"])

    
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
        fatalError("")
    }

    let x: Float
    let y: Float
    let z: Float
    let alpha: Float
//    let space: XYZColorSpace
    let space: ColorSpace
}
