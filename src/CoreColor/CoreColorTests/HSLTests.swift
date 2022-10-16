//
//  HSLTests.swift
//  CoreColorTests
//
//  Created by x on 10/16/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class HSLTests: XCTestCase {

    func test_HSL_to_RGB() throws {
        try check_HSL_to_RGB(hsl: HSL(h: Float.nan, s: 0.00, l: 0.00, alpha: 1.0),
                             rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_HSL_to_RGB(hsl: HSL(h: 64.80, s: 0.18, l: 0.18, alpha: 1.0),
                             rgb: RGB(r: 0.207216, g: 0.2124, b: 0.1476, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_HSL_to_RGB(hsl: HSL(h: 144.00, s: 0.50, l: 0.60, alpha: 1.0),
                             rgb: RGB(r: 0.4, g: 0.8, b: 0.56, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_HSL_to_RGB(hsl: HSL(h: Float.nan, s: 0.00, l: 1.00, alpha: 1.0),
                             rgb: RGB(r: 1.00, g: 1.00, b: 1.00, alpha: 1.0, space: RGBColorSpaces.sRGB))
    }

    func check_HSL_to_RGB(hsl: HSL, rgb: RGB) throws {
        try assertIsSameRGB(hsl.toSRGB(), rgb)
    }

    func assertIsSameRGB(_ a: RGB, _ b: RGB) throws {
        XCTAssertEqual(a.r, b.r, accuracy: 1e-5)
        XCTAssertEqual(a.g, b.g, accuracy: 1e-5)
        XCTAssertEqual(a.b, b.b, accuracy: 1e-5)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }
}
