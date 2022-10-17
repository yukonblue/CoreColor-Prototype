//
//  HSVTests.swift
//  CoreColorTests
//
//  Created by x on 10/17/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class HSVTests: XCTestCase {

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
        try assertIsSameRGB(hsv.toSRGB(), rgb)
    }

    func assertIsSameRGB(_ a: RGB, _ b: RGB) throws {
        XCTAssertEqual(a.r, b.r, accuracy: 1e-5)
        XCTAssertEqual(a.g, b.g, accuracy: 1e-5)
        XCTAssertEqual(a.b, b.b, accuracy: 1e-5)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }
}
