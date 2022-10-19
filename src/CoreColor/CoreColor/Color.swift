//
//  Color.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

protocol Color {

    associatedtype AssociatedColorSpace: ColorSpace

    var alpha: Float { get }

    var space: AssociatedColorSpace { get }

    func toSRGB() -> RGB

    func toHSL() -> HSL

    func toHSV() -> HSV

    func toCMYK() -> CMYK
    
    func toXYZ() -> XYZ

    func toLAB() -> LAB
}

extension Color {

    func toHSL() -> HSL {
        self.toSRGB().toHSL()
    }

    func toHSV() -> HSV {
        self.toSRGB().toHSV()
    }

    func toCMYK() -> CMYK {
        self.toSRGB().toCMYK()
    }

    func toXYZ() -> XYZ {
        self.toSRGB().toXYZ()
    }

    func toLAB() -> LAB {
        self.toXYZ().toLAB()
    }
}
