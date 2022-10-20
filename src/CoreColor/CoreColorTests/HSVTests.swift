//
//  HSVTests.swift
//  CoreColorTests
//
//  Created by x on 10/17/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class HSVTests: ColorTestCase {

    func test_HSV_to_RGB() throws {
        try check_HSV_to_RGB(hsv: HSV(h: Float.nan, s: 0.00, v: 0.00, alpha: 1.0),
                             rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_HSV_to_RGB(hsv: HSV(h: 64.80, s: 0.18, v: 0.18, alpha: 1.0),
                             rgb: RGB(r: 0.177408, g: 0.18, b: 0.1476, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_HSV_to_RGB(hsv: HSV(h: 144.00, s: 0.50, v: 0.60, alpha: 1.0),
                             rgb: RGB(r: 0.3, g: 0.6, b: 0.42, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_HSV_to_RGB(hsv: HSV(h: 0.0, s: 1.00, v: 1.00, alpha: 1.0),
                             rgb: RGB(r: 1.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB))
    }

    func check_HSV_to_RGB(hsv: HSV, rgb: RGB) throws {
        try check_conversion(hsv) { (src: HSV) -> RGB in
            src.toSRGB()
        } check: { converted, _ in
            try assertIsSameRGB(converted, rgb)
        }
    }

    func test_HSV_to_XYZ() throws {
        try check_conversion(HSV(h: 144.00, s: 0.50, v: 0.60, alpha: 1.0)) { (src: HSV) -> XYZ in
            src.toXYZ()
        } check: { converted, _ in
            XCTAssertTrue(converted.x.isFinite)
            XCTAssertTrue(converted.y.isFinite)
            XCTAssertTrue(converted.z.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_HSV_to_HSL() throws {
        try check_conversion(HSV(h: 144.00, s: 0.50, v: 0.60, alpha: 1.0)) { (src: HSV) -> HSL in
            src.toHSL()
        } check: { converted, _ in
            XCTAssertTrue(converted.h.isFinite)
            XCTAssertTrue(converted.s.isFinite)
            XCTAssertTrue(converted.l.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_HSV_to_LAB() throws {
        try check_conversion(HSV(h: 144.00, s: 0.50, v: 0.60, alpha: 1.0)) { (src: HSV) -> LAB in
            src.toLAB()
        } check: { converted, _ in
            XCTAssertTrue(converted.l.isFinite)
            XCTAssertTrue(converted.a.isFinite)
            XCTAssertTrue(converted.b.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_HSV_to_LUV() throws {
        try check_conversion(HSV(h: 144.00, s: 0.50, v: 0.60, alpha: 1.0)) { (src: HSV) -> LUV in
            src.toLUV()
        } check: { converted, _ in
            XCTAssertTrue(converted.l.isFinite)
            XCTAssertTrue(converted.u.isFinite)
            XCTAssertTrue(converted.v.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_HSV_to_CMYK() throws {
        try check_conversion(HSV(h: 144.00, s: 0.50, v: 0.60, alpha: 1.0)) { (src: HSV) -> CMYK in
            src.toCMYK()
        } check: { converted, _ in
            XCTAssertTrue(converted.c.isFinite)
            XCTAssertTrue(converted.m.isFinite)
            XCTAssertTrue(converted.y.isFinite)
            XCTAssertTrue(converted.k.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_HSV_to_HSV() throws {
        try check_conversion(HSV(h: 144.00, s: 0.50, v: 0.60, alpha: 1.0)) { (src: HSV) -> HSV in
            src.toHSV()
        } check: { converted, src in
            XCTAssertEqual(converted.h, src.h)
            XCTAssertEqual(converted.s, src.s)
            XCTAssertEqual(converted.v, src.v)
            XCTAssertEqual(converted.alpha, src.alpha)
        }
    }
}
