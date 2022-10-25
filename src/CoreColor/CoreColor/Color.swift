//
//  Color.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

public protocol Color {

    associatedtype AssociatedColorSpace: ColorSpace

    var alpha: Float { get }

    var space: AssociatedColorSpace { get }

    func toSRGB() -> RGB

    func toHSL() -> HSL

    func toHSV() -> HSV

    func toCMYK() -> CMYK
    
    func toXYZ() -> XYZ

    func toLAB() -> LAB

    func toLUV() -> LUV
}

extension Color {

    public func toHSL() -> HSL {
        self.toSRGB().toHSL()
    }

    public func toHSV() -> HSV {
        self.toSRGB().toHSV()
    }

    public func toCMYK() -> CMYK {
        self.toSRGB().toCMYK()
    }

    public func toXYZ() -> XYZ {
        self.toSRGB().toXYZ()
    }

    public func toLAB() -> LAB {
        self.toXYZ().toLAB()
    }

    public func toLUV() -> LUV {
        self.toXYZ().toLUV()
    }
}
