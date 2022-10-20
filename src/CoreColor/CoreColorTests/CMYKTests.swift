//
//  CMYKTests.swift
//  CoreColorTests
//
//  Created by x on 10/16/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class CMYKTests: ColorTestCase {

    func test_CMYK_to_RGB() throws {
        try check_CMYK_to_RGB(cmyk: CMYK(c: 0.00, m: 0.00, y: 0.00, k: 0.00, alpha: 1.0),
                              rgb: RGB(r: 1.0, g: 1.0, b: 1.0, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_CMYK_to_RGB(cmyk: CMYK(c: 0.18, m: 0.18, y: 0.18, k: 0.18, alpha: 1.0),
                              rgb: RGB(r: 0.6724, g: 0.6724, b: 0.6724, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_CMYK_to_RGB(cmyk: CMYK(c: 0.40, m: 0.50, y: 0.60, k: 0.70, alpha: 1.0),
                              rgb: RGB(r: 0.18, g: 0.15, b: 0.12, alpha: 1.0, space: RGBColorSpaces.sRGB))

        // TODO: Get this work ..
//        try check_CMYK_to_RGB(cmyk: CMYK(c: 100, m: 100, y: 100, k: 100, alpha: 1.0),
//                              rgb: RGB(r: 0.0, g: 0.0, b: 0.0, alpha: 1.0, space: RGBColorSpaces.sRGB))
    }

    func check_CMYK_to_RGB(cmyk: CMYK, rgb: RGB) throws {
        try check_conversion(cmyk) { (src: CMYK) -> RGB in
            src.toSRGB()
        } check: { converted, _ in
            try assertIsSameRGB(converted, rgb)
        }
    }

    func test_CMYK_to_XYZ() throws {
        try check_conversion(CMYK(c: 0.0, m: 0.0, y: 0.0, k: 0.0, alpha: 1.0)) { (src: CMYK) -> XYZ in
            src.toXYZ()
        } check: { converted, _ in
            XCTAssertTrue(converted.x.isFinite)
            XCTAssertTrue(converted.y.isFinite)
            XCTAssertTrue(converted.z.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_CMYK_to_LAB() throws {
        try check_conversion(CMYK(c: 0.0, m: 0.0, y: 0.0, k: 0.0, alpha: 1.0)) { (src: CMYK) -> LAB in
            src.toLAB()
        } check: { converted, _ in
            XCTAssertTrue(converted.l.isFinite)
            XCTAssertTrue(converted.a.isFinite)
            XCTAssertTrue(converted.b.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_CMYK_to_LUV() throws {
        try check_conversion(CMYK(c: 0.0, m: 0.0, y: 0.0, k: 0.0, alpha: 1.0)) { (src: CMYK) -> LUV in
            src.toLUV()
        } check: { converted, _ in
            XCTAssertTrue(converted.l.isFinite)
            XCTAssertTrue(converted.u.isFinite)
            XCTAssertTrue(converted.v.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_CMYK_to_HSV() throws {
        try check_conversion(CMYK(c: 0.0, m: 0.0, y: 0.0, k: 0.0, alpha: 1.0)) { (src: CMYK) -> HSV in
            src.toHSV()
        } check: { converted, _ in
//            XCTAssertTrue(converted.h.isFinite) // TODO: look into this
            XCTAssertTrue(converted.s.isFinite)
            XCTAssertTrue(converted.v.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_CMYK_to_HSL() throws {
        try check_conversion(CMYK(c: 0.0, m: 0.0, y: 0.0, k: 0.0, alpha: 1.0)) { (src: CMYK) -> HSL in
            src.toHSL()
        } check: { converted, _ in
//            XCTAssertTrue(converted.h.isFinite) // TODO: look into this
            XCTAssertTrue(converted.s.isFinite)
            XCTAssertTrue(converted.l.isFinite)
            XCTAssertTrue(converted.alpha.isFinite)
        }
    }

    func test_CMYK_to_CMYK() throws {
        try check_conversion(CMYK(c: 0.0, m: 0.0, y: 0.0, k: 0.0, alpha: 1.0)) { (src: CMYK) -> CMYK in
            src.toCMYK()
        } check: { converted, src in
            XCTAssertEqual(converted.c, src.c)
            XCTAssertEqual(converted.y, src.y)
            XCTAssertEqual(converted.m, src.m)
            XCTAssertEqual(converted.k, src.k)
            XCTAssertEqual(converted.alpha, src.alpha)
        }
    }
}
