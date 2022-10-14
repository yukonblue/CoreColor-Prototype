//
//  Color.swift
//  CoreColor
//
//  Created by x on 10/14/2022.
//

import Foundation

protocol Color {

    var alpha: Float { get }

    var space: ColorSpace { get }
    
    func toSRGB() -> RGB

    func toHSL() -> HSL

    func toHSV() -> HSV

    func toCMYK() -> CMYK
    
    func toXYZ() -> XYZ

    func toLAB() -> LAB
}



struct HSL: Color {
    func toSRGB() -> RGB {
        fatalError("")
    }

    let alpha: Float
    
    let space: ColorSpace
}

struct HSV: Color {
    func toSRGB() -> RGB {
        fatalError("")
    }

    let alpha: Float
    
    let space: ColorSpace
}

struct CMYK: Color {
    func toSRGB() -> RGB {
        fatalError("")
    }

    let alpha: Float
    
    let space: ColorSpace
}

struct LAB: Color {
    func toSRGB() -> RGB {
        fatalError("")
    }

    let alpha: Float
    
    let space: ColorSpace
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
