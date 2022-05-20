import XCTest
@testable import SwiftMath

protocol AlmostEquatable {
    func almostEquals(rhs: Self)
}

class Vec3Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testInit() {
       let expected: [Double] = [1.0, 2.0, 3.0]
       let candidate = DVec3(x: 1.0, y: 2.0, z: 3.0)
       let actual = [candidate.x, candidate.y, candidate.z]
       XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEqual() {
        XCTAssertTrue(DVec3(1.231999999).almostEquals(DVec3(1.232)), "Almost Equal failed")
    }

    func testAxialUnitConstants() {
        let expected = [
            [1.0, 0.0, 0.0],
            [0.0, 1.0, 0.0],
            [0.0, 0.0, 1.0]
        ]
        let actual = [
            DVec3.xUnit,
            DVec3.yUnit,
            DVec3.zUnit,
        ].map { v in [v.x, v.y, v.z]}
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }

    func testLength() {
        let expected: Double = 7.0
        let candidate = DVec3(x: 2.0, y: 3.0, z: 6.0)
        let actual = candidate.len()
        XCTAssertEqual(actual, expected, "Length failed")
    }
}
