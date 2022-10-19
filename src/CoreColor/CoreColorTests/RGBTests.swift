//
//  RGBTests.swift
//  CoreColorTests
//
//  Created by x on 10/17/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class RGBTests: XCTestCase {

    func test_RGB_to_HSV() throws {
        try check_RGB_to_HSV(rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsv: HSV(h: Float.nan, s: 0.00, v: 0.00, alpha: 1.0))

        try check_RGB_to_HSV(rgb: RGB(r: 0.18, g: 0.18, b: 0.18, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsv: HSV(h: Float.nan, s: 0.00, v: 0.18, alpha: 1.0))

        try check_RGB_to_HSV(rgb: RGB(r: 0.40, g: 0.50, b: 0.60, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsv: HSV(h: 210.0, s: 0.33333333, v: 0.6, alpha: 1.0))

        try check_RGB_to_HSV(rgb: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsv: HSV(h: Float.nan, s: 0.00, v: 1.00, alpha: 1.0))
    }

    func test_RGB_to_HSL() throws {
        try check_RGB_to_HSL(rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsl: HSL(h: Float.nan, s: 0.00, l: 0.00, alpha: 1.0))

        try check_RGB_to_HSL(rgb: RGB(r: 0.18, g: 0.18, b: 0.18, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsl: HSL(h: Float.nan, s: 0.00, l: 0.18, alpha: 1.0))

        try check_RGB_to_HSL(rgb: RGB(r: 0.40, g: 0.50, b: 0.60, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsl: HSL(h: 210.0, s: 0.20, l: 0.50, alpha: 1.0))

        try check_RGB_to_HSL(rgb: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             hsl: HSL(h: Float.nan, s: 0.00, l: 1.00, alpha: 1.0))
    }

    func test_RGB_to_XYZ() throws {
        try check_RGB_to_XYZ(rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             xyz: XYZ(x: 0.00, y: 0.00, z: 0.00, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_RGB_to_XYZ(rgb: RGB(r: 0.18, g: 0.18, b: 0.18, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             xyz: XYZ(x: 0.0258636, y: 0.02721178, z: 0.0296352, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_RGB_to_XYZ(rgb: RGB(r: 0.40, g: 0.50, b: 0.60, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             xyz: XYZ(x: 0.18882301, y: 0.20432514, z: 0.33086999, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_RGB_to_XYZ(rgb: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             xyz: XYZ(x: 0.95045593, y: 1.0, z: 1.08905775, alpha: 1.0, space: XYZColorSpaces.XYZ65))
    }

    func test_RGB_to_CMYK() throws {
        try check_RGB_to_CMYK(rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              cmyk: CMYK(c: 0.00, m: 0.00, y: 0.00, k: 1.00, alpha: 1.00))

        try check_RGB_to_CMYK(rgb: RGB(r: 0.18, g: 0.18, b: 0.18, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              cmyk: CMYK(c: 0.00, m: 0.00, y: 0.00, k: 0.82, alpha: 1.00))

        try check_RGB_to_CMYK(rgb: RGB(r: 0.40, g: 0.50, b: 0.60, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              cmyk: CMYK(c: 0.33333333, m: 0.16666667, y: 0.0, k: 0.4, alpha: 1.00))

        try check_RGB_to_CMYK(rgb: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              cmyk: CMYK(c: 0.00, m: 0.00, y: 0.00, k: 0.00, alpha: 1.00))
    }

    func test_RGB_to_LUV() throws {
        try check_RGB_to_LUV(rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             luv: LUV(l: 0.00, u: 0.00, v: 0.00, alpha: 1.00, space: LUVColorSpaces.LUV65))

        try check_RGB_to_LUV(rgb: RGB(r: 0.18, g: 0.18, b: 0.18, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             luv: LUV(l: 18.89075051, u: 0.00, v: 0.00, alpha: 1.00, space: LUVColorSpaces.LUV65))

        try check_RGB_to_LUV(rgb: RGB(r: 0.40, g: 0.50, b: 0.60, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             luv: LUV(l: 52.32273694, u: -13.5765706, v: -23.98061646, alpha: 1.00, space: LUVColorSpaces.LUV65))

        try check_RGB_to_LUV(rgb: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                             luv: LUV(l: 100.00, u: 0.00, v: 0.00, alpha: 1.00, space: LUVColorSpaces.LUV65))
    }

    func test_sRGB_to_sRGB() throws {
        try check_RGB_to_sRGB(src: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              dst: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_RGB_to_sRGB(src: RGB(r: 0.18, g: 0.18, b: 0.18, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              dst: RGB(r: 0.18, g: 0.18, b: 0.18, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_RGB_to_sRGB(src: RGB(r: 0.40, g: 0.50, b: 0.60, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              dst: RGB(r: 0.40, g: 0.50, b: 0.60, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_RGB_to_sRGB(src: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB),
                              dst: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB))
    }

    private func check_RGB_to_sRGB(src: RGB, dst: RGB) throws {
        let converted = src.toSRGB()
        assertEqual(converted.r, dst.r, accuracy: 1e-5)
        assertEqual(converted.g, dst.g, accuracy: 1e-5)
        assertEqual(converted.b, dst.b, accuracy: 1e-5)
        assertEqual(converted.alpha, dst.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    private func check_RGB_to_LUV(rgb: RGB, luv: LUV) throws {
        let converted = rgb.toLUV()
        assertEqual(converted.l, luv.l, accuracy: 1e-5)
        assertEqual(converted.u, luv.u, accuracy: 1e-5)
        assertEqual(converted.v, luv.v, accuracy: 1e-4) // TODO: more accuracy
        assertEqual(converted.alpha, luv.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    private func check_RGB_to_HSV(rgb: RGB, hsv: HSV) throws {
        let converted = rgb.toHSV()
        assertEqual(converted.h, hsv.h, accuracy: 1e-5)
        assertEqual(converted.s, hsv.s, accuracy: 1e-5)
        assertEqual(converted.v, hsv.v, accuracy: 1e-5)
        assertEqual(converted.alpha, hsv.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    private func check_RGB_to_HSL(rgb: RGB, hsl: HSL) throws {
        let converted = rgb.toHSL()
        assertEqual(converted.h, hsl.h, accuracy: 1e-6)
        assertEqual(converted.s, hsl.s, accuracy: 1e-5)
        assertEqual(converted.l, hsl.l, accuracy: 1e-5)
        assertEqual(converted.alpha, hsl.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    private func check_RGB_to_XYZ(rgb: RGB, xyz: XYZ) throws {
        let converted = rgb.toXYZ()
        assertEqual(converted.x, xyz.x, accuracy: 1e-5)
        assertEqual(converted.y, xyz.y, accuracy: 1e-5)
        assertEqual(converted.z, xyz.z, accuracy: 1e-5)
        assertEqual(converted.alpha, xyz.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    private func check_RGB_to_CMYK(rgb: RGB, cmyk: CMYK) throws {
        let converted = rgb.toCMYK()
        assertEqual(converted.c, cmyk.c, accuracy: 1e-5)
        assertEqual(converted.m, cmyk.m, accuracy: 1e-5)
        assertEqual(converted.y, cmyk.y, accuracy: 1e-5)
        assertEqual(converted.k, cmyk.k, accuracy: 1e-5)
        assertEqual(converted.alpha, cmyk.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    private func assertEqual(_ a: Float, _ b: Float, accuracy: Float = 1e-5) {
        switch (a.isNaN, b.isNaN) {
        case (true, true):
            break
        default:
            XCTAssertEqual(a, b, accuracy: accuracy)
        }
    }
}
