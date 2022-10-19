//
//  RGBColorspace.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation
import simd

protocol RGBColorSpaceRepresentable: WhitePointColorSpace, AnyObject {

    ///
    /// Transfer functions for the RGB colorspace.
    var transferFunctions: RGBTransferFunctions { get }

    ///
    /// A 3×3 matrix that transforms linear-light values in this space to [XYZ] tristimulus values.
    ///
    var matrixToXyz: matrix_float3x3 { get }

    ///
    /// A 3×3 matrix that transforms [XYZ] tristimulus values to linear-light values in this space.
    ///
    var matrixFromXyz: matrix_float3x3 { get }
}

///
/// Color Component Transfer Functions (CCTFs) for encoding and decoding components of [RGB] color spaces.
///
protocol RGBTransferFunctions {

    ///
    /// Electro-Optical Transfer Function (EOTF / EOCF)
    ///
    /// This function decodes non-linear signal values into linear-light values.
    ///
    func eotf(_: Float) -> Float

    ///
    /// The Opto-Electronic Transfer Function (OETF / OECF)
    ///
    /// This function encodes linear scene light into non-linear signal values.
    ///
    func oetf(_: Float) -> Float
}

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

struct GammaTransferFunctions: RGBTransferFunctions {

    let gamma: Float

    func eotf(_ val: Float) -> Float {
        Float(val.spow(gamma))
    }

    func oetf(_ val: Float) -> Float {
        Float(val.spow(1.0 / gamma))
    }
}

struct LinearTransferFunctions: RGBTransferFunctions {

    func eotf(_ val: Float) -> Float {
        val
    }

    func oetf(_ val: Float) -> Float {
        val
    }
}

struct SRGBTransferFunctions : RGBTransferFunctions {

    func oetf(_ x: Float) -> Float {
        x <= 0.0031308 ? x * 12.92 : 1.055 * x.spow(1 / 2.4) - 0.055
    }

    func eotf(_ x: Float) -> Float {
        x <= 0.04045 ? x / 12.92 : ((x + 0.055) / 1.055).spow(2.4)
    }
}
