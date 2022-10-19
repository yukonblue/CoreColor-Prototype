//
//  XYZTests.swift
//  CoreColorTests
//
//  Created by x on 10/17/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class XYZTests: XCTestCase {

    func test_XYZ_to_SRGB() throws {
        try check_XYZ_to_RGB(xyz: XYZ(x: 0.00, y: 0.00, z: 0.00, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             rgb: RGB(r: 0.00, g: 0.00, b: 0.00, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_XYZ_to_RGB(xyz: XYZ(x: 0.18, y: 0.18, z: 0.18, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             rgb: RGB(r: 0.50307213, g: 0.45005582, b: 0.44114606, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_XYZ_to_RGB(xyz: XYZ(x: 0.40, y: 0.50, z: 0.60, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             rgb: RGB(r: 0.51535521, g: 0.78288241, b: 0.77013935, alpha: 1.0, space: RGBColorSpaces.sRGB))

        try check_XYZ_to_RGB(xyz: XYZ(x: 1.0, y: 1.00, z: 1.00, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             rgb: RGB(r: 1.08523261, g: 0.97691161, b: 0.95870753, alpha: 1.0, space: RGBColorSpaces.sRGB))
    }

    func test_XYZ_to_LAB() throws {
        try check_XYZ_to_LAB(xyz: XYZ(x: 0.25, y: 0.50, z: 0.75, alpha: 1.0, space: XYZColorSpaces.XYZ50),
                             lab: LAB(l: 76.06926101, a: -78.02949711, b: -34.99756832, alpha: 1.0, space: LABColorSpaces.LAB50))
    }

    func test_XYZ_to_LUV() throws {
        try check_XYZ_to_LUV(xyz: XYZ(x: 0.00, y: 0.00, z: 0.00, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             luv: LUV(l: 0.00, u: 0.00, v: 0.00, alpha: 1.0, space: LUVColorSpaces.LUV65))

        try check_XYZ_to_LUV(xyz: XYZ(x: 0.18, y: 0.18, z: 0.18, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             luv: LUV(l: 49.49610761, u: 8.16943249, v: 3.4516013, alpha: 1.0, space: LUVColorSpaces.LUV65))

        try check_XYZ_to_LUV(xyz: XYZ(x: 0.40, y: 0.50, z: 0.60, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             luv: LUV(l: 76.06926101, u: -32.51658072, v: -4.35360349, alpha: 1.0, space: LUVColorSpaces.LUV65))

        try check_XYZ_to_LUV(xyz: XYZ(x: 1.00, y: 1.00, z: 1.00, alpha: 1.0, space: XYZColorSpaces.XYZ65),
                             luv: LUV(l: 100.0, u: 16.50520189, v: 6.97348026, alpha: 1.0, space: LUVColorSpaces.LUV65))

        // XYZ50 -> LUV50
        try check_XYZ_to_LUV(xyz: XYZ(x: 0.25, y: 0.5, z: 0.75, alpha: 1.0, space: XYZColorSpaces.XYZ50),
                             luv: LUV(l: 76.06926101, u: -107.96735088, v: -37.65708044, alpha: 1.0, space: LUVColorSpaces.LUV50))
    }

    func check_XYZ_to_LUV(xyz: XYZ, luv: LUV) throws {
        let converted = xyz.toLUV()
        assertEqual(converted.l, luv.l, accuracy: 1e-5)
        assertEqual(converted.u, luv.u, accuracy: 1e-4) // TODO: More accuracy
        assertEqual(converted.v, luv.v, accuracy: 1e-4) // TODO: More accuracy
        assertEqual(converted.alpha, luv.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    func check_XYZ_to_RGB(xyz: XYZ, rgb: RGB) throws {
        try assertIsSameRGB(xyz.toSRGB(), rgb)
    }

    func check_XYZ_to_LAB(xyz: XYZ, lab: LAB) throws {
        try assertIsSameLAB(xyz.toLAB(), lab)
    }

    func assertIsSameRGB(_ a: RGB, _ b: RGB) throws {
        XCTAssertEqual(a.r, b.r, accuracy: 1e-5)
        XCTAssertEqual(a.g, b.g, accuracy: 1e-5)
        XCTAssertEqual(a.b, b.b, accuracy: 1e-5)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }

    func assertIsSameLAB(_ a: LAB, _ b: LAB) throws {
        XCTAssertEqual(a.l, b.l, accuracy: 1e-5)
        XCTAssertEqual(a.a, b.a, accuracy: 1e-4) // TODO: Need more accuracy
        XCTAssertEqual(a.b, b.b, accuracy: 1e-5)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-5)
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
