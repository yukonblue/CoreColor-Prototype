//
//  CMYKTests.swift
//  CoreColorTests
//
//  Created by x on 10/16/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class CMYKTests: XCTestCase {

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
        try assertIsSameRGB(cmyk.toSRGB(), rgb)
    }

    func assertIsSameRGB(_ a: RGB, _ b: RGB) throws {
        XCTAssertEqual(a.r, b.r, accuracy: 1e-5)
        XCTAssertEqual(a.g, b.g, accuracy: 1e-5)
        XCTAssertEqual(a.b, b.b, accuracy: 1e-5)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }
}
