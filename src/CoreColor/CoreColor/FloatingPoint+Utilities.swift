//
//  Utilities.swift
//  CoreColor
//
//  Created by x on 10/25/2022.
//

import Foundation

extension BinaryFloatingPoint {

    var double: Double {
        Double(self)
    }
}

extension Double {

    func spow(_ p: Self) -> Self {
        let sign: Double = self < Self(0) ? -1.0 : 1.0
        return pow(abs(self.double), p.double) * sign
    }
}

extension Float {

    func spow(_ p: Self) -> Self {
        let sign: Float = self < Self(0) ? -1.0 : 1.0
        return pow(abs(self), p) * sign
    }
}
