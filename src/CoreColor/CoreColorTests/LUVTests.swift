//
//  LUVTests.swift
//  CoreColorTests
//
//  Created by x on 10/19/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class LUVTests: XCTestCase {

    func test_LUV_to_XYZ() throws {
        try check_LUV_to_XYZ(luv: LUV(l: 0.0, u: 0.0, v: 0.0, alpha: 1.0, space: LUVColorSpaces.LUV65),
                             xyz: XYZ(x: 0.0, y: 0.0, z: 0.0, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_LUV_to_XYZ(luv: LUV(l: 18.00, u: 18.00, v: 18.00, alpha: 1.0, space: LUVColorSpaces.LUV65),
                             xyz: XYZ(x: 0.02854945, y: 0.02518041, z: 0.00312744, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_LUV_to_XYZ(luv: LUV(l: 40.00, u: 50.0, v: 60.0, alpha: 1.0, space: LUVColorSpaces.LUV65),
                             xyz: XYZ(x: 0.12749789, y: 0.11250974, z: -0.02679452, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_LUV_to_XYZ(luv: LUV(l: 100.0, u: 100.0, v: 100.0, alpha: 1.0, space: LUVColorSpaces.LUV65),
                             xyz: XYZ(x: 1.13379604, y: 1.0, z: 0.12420117, alpha: 1.0, space: XYZColorSpaces.XYZ65))
    }

    func check_LUV_to_XYZ(luv: LUV, xyz: XYZ) throws {
        try assertIsSameXYZ(luv.toXYZ(), xyz)
    }

    func assertIsSameXYZ(_ a: XYZ, _ b: XYZ) throws {
        XCTAssertEqual(a.x, b.x, accuracy: 1e-5)
        XCTAssertEqual(a.y, b.y, accuracy: 1e-5)
        XCTAssertEqual(a.z, b.z, accuracy: 1e-5)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }
}
