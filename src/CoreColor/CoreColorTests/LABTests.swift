//
//  LABTests.swift
//  CoreColorTests
//
//  Created by x on 10/16/2022.
//

import Foundation

import XCTest
@testable import CoreColor

class LABTests: XCTestCase {

    func test_LAB_to_XYZ() throws {
        try check_LAB_to_XYZ(lab: LAB(l: 0.00, a: 0.00, b: 0.00, alpha: 1.0, space: LABColorSpaces.LAB65),
                             xyz: XYZ(x: 0.0, y: 0.0, z: 0.0, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_LAB_to_XYZ(lab: LAB(l: 18.00, a: 18.00, b: 18.00, alpha: 1.0, space: LABColorSpaces.LAB65),
                             xyz: XYZ(x: 0.0338789, y: 0.02518041, z: 0.0091147, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_LAB_to_XYZ(lab: LAB(l: 40.00, a: 50.00, b: 60.00, alpha: 1.0, space: LABColorSpaces.LAB65),
                             xyz: XYZ(x: 0.18810403, y: 0.11250974, z: 0.00626937, alpha: 1.0, space: XYZColorSpaces.XYZ65))

        try check_LAB_to_XYZ(lab: LAB(l: 100.00, a: 100.00, b: 100.00, alpha: 1.0, space: LABColorSpaces.LAB65),
                             xyz: XYZ(x: 1.64238784, y: 1.0, z: 0.13613222, alpha: 1.0, space: XYZColorSpaces.XYZ65))
    }

    func check_LAB_to_XYZ(lab: LAB, xyz: XYZ) throws {
        try assertIsSameXYZ(lab.toXYZ(), xyz)
    }

    func assertIsSameXYZ(_ a: XYZ, _ b: XYZ) throws {
        XCTAssertEqual(a.x, b.x, accuracy: 1e-5)
        XCTAssertEqual(a.y, b.y, accuracy: 1e-5)
        XCTAssertEqual(a.z, b.z, accuracy: 1e-5)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-5)
        // TODO: Check colorspace!
    }
}
