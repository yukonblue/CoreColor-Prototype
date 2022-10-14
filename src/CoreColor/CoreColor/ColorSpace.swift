//
//  ColorSpace.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

protocol ColorSpace {

//    associatedtype T: Color

    var name: String { get }

    var components: [ColorComponentInfo] { get }

//    func convert(fromColor: Color) -> T
}

struct ColorComponentInfo {

    /// The name of this component.
    let name: String

    /// `true` if this component uses polar coordinates (e.g. a hue),
    /// and `false` if it's rectangular.
    let isPolar: Bool
}

protocol WhitePointColorSpace {

//    associatedtype T: Color

    /// The white point that colors in this space are calculated relative to.
    var whitePoint: WhitePoint { get }
}
