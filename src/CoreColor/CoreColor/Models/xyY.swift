//
//  xyY.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

struct xyY: Equatable {

    let x: Float
    let y: Float
    let Y: Float = 1.0

    var z: Float {
        1 - x - y
    }

    var X: Float {
        x * Y / y
    }

    var Z: Float {
        (1 - x - y) * Y / y
    }
}
