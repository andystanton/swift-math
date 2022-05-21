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

    func testDVec3Init() {
       let expected: [Double] = [1, 2, 3]
       let candidate = DVec3(x: 1, y: 2, z: 3)
       let actual = [candidate.x, candidate.y, candidate.z]
       XCTAssertEqual(actual, expected, "Init failed")
    }

    func testDVec3AlmostEqual() {
        XCTAssertTrue(DVec3(1.231999999).almostEquals(DVec3(1.232)), "Almost Equal failed")
    }

    func testDVec3AxialUnitConstants() {
        let expected: [[Double]] = [
            [1, 0, 0],
            [0, 1, 0],
            [0, 0, 1]
        ]
        let actual = [
            DVec3.xUnit,
            DVec3.yUnit,
            DVec3.zUnit,
        ].map { v in [v.x, v.y, v.z]}
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }

    func testDVec3Length() {
        let expected: Double = 7
        let candidate = DVec3(x: 2, y: 3, z: 6)
        let actual = candidate.len()
        XCTAssertEqual(actual, expected, "Length failed")
    }

    func testDVec3Normalise() {
        let expected = DVec3((1/3).squareRoot())
        let candidate = DVec3(x: 1, y: 1, z: 1)
        let actual = candidate.normalize()
        XCTAssertTrue(actual.almostEquals(expected), "Normalise failed")
    }

    func testDVec3UniformScale() {
        let expected = DVec3(x: 2, y: 4, z: 6)
        let candidate = DVec3(x: 1, y: 2, z: 3)
        let actual = candidate * 2
        XCTAssertTrue(actual.almostEquals(expected), "Uniform Scale failed")
    }

    func testDVec3NonUniformScale() {
        let expected = DVec3(x: 2, y: 6, z: 12)
        let candidate = DVec3(x: 1, y: 2, z: 3)
        let actual = candidate * DVec3(x: 2, y: 3, z: 4)
        XCTAssertTrue(actual.almostEquals(expected), "Non-Uniform Scale failed")
    }

    func testDVec3UniformDivison() {
        let expected = DVec3(x: 1, y: 2, z: 3)
        let candidate = DVec3(x: 2, y: 4, z: 6)
        let actual = candidate / 2
        XCTAssertEqual(actual, expected, "Uniform Division failed")
    }

    func testDVec3NonUniformDivison() {
        let expected = DVec3(x: 1, y: 2, z: 3)
        let candidate = DVec3(x: 2, y: 6, z: 12)
        let actual = candidate / DVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Non-Uniform Division failed")
    }

    func testDVec3Addition() {
        let expected = DVec3(x: 3, y: 5, z: 7)
        let candidate = DVec3(x: 1, y: 2, z: 3)
        let actual = candidate + DVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Addition failed")
    }

    func testDVec3Subtraction() {
        let expected = DVec3(x: 1, y: 2, z: 3)
        let candidate = DVec3(x: 3, y: 5, z: 7)
        let actual = candidate - DVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Subtraction failed")
    }
}
