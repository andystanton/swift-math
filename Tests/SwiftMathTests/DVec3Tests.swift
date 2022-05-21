import XCTest
@testable import SwiftMath

class DVec3Tests: XCTestCase {
    func testInit() {
       let expected: [Double] = [1, 2, 3]
       let candidate = DVec3(x: 1, y: 2, z: 3)
       let actual = [candidate.x, candidate.y, candidate.z]
       XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEqual() {
        XCTAssertTrue(DVec3(1.231999999).almostEquals(DVec3(1.232)), "Almost Equal failed")
    }

    func testAxialUnitConstants() {
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

    func testLength() {
        let expected: Double = 7
        let candidate = DVec3(x: 2, y: 3, z: 6)
        let actual = candidate.len()
        XCTAssertEqual(actual, expected, "Length failed")
    }

    func testNormalise() {
        let expected = DVec3((1/3).squareRoot())
        let candidate = DVec3(x: 1, y: 1, z: 1)
        let actual = candidate.normalize()
        XCTAssertTrue(actual.almostEquals(expected), "Normalise failed")
    }

    func testUniformScale() {
        let expected = DVec3(x: 2, y: 4, z: 6)
        let candidate = DVec3(x: 1, y: 2, z: 3)
        let actual = candidate * 2
        XCTAssertTrue(actual.almostEquals(expected), "Uniform Scale failed")
    }

    func testNonUniformScale() {
        let expected = DVec3(x: 2, y: 6, z: 12)
        let candidate = DVec3(x: 1, y: 2, z: 3)
        let actual = candidate * DVec3(x: 2, y: 3, z: 4)
        XCTAssertTrue(actual.almostEquals(expected), "Non-Uniform Scale failed")
    }

    func testUniformDivison() {
        let expected = DVec3(x: 1, y: 2, z: 3)
        let candidate = DVec3(x: 2, y: 4, z: 6)
        let actual = candidate / 2
        XCTAssertEqual(actual, expected, "Uniform Division failed")
    }

    func testNonUniformDivison() {
        let expected = DVec3(x: 1, y: 2, z: 3)
        let candidate = DVec3(x: 2, y: 6, z: 12)
        let actual = candidate / DVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Non-Uniform Division failed")
    }

    func testAddition() {
        let expected = DVec3(x: 3, y: 5, z: 7)
        let candidate = DVec3(x: 1, y: 2, z: 3)
        let actual = candidate + DVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Addition failed")
    }

    func testSubtraction() {
        let expected = DVec3(x: 1, y: 2, z: 3)
        let candidate = DVec3(x: 3, y: 5, z: 7)
        let actual = candidate - DVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Subtraction failed")
    }

    func testDotProduct() {
        let candidate = DVec3(x: 1, y: 0, z: 0)
        let testValues = [
            DVec3(x: 1, y: 0, z: 0),
            DVec3(x: -1, y: 0, z: 0),
            DVec3(x: 0, y: 1, z: 0),
            DVec3(x: 0, y: -1, z: 0),
            DVec3(x: 0, y: 0, z: 1),
            DVec3(x: 0, y: 0, z: -1),
            DVec3(x: 0.5, y: 0.8660254038, z: 0),
            DVec3(x: -0.5, y: -0.8660254038, z: 0),
        ]
        let expected = [
            1,
            -1,
            0,
            0,
            0,
            0,
            0.5,
            -0.5,
        ]
        let actual = testValues.map(candidate.dot)
        XCTAssertEqual(actual, expected, "Dot Product failed")
    }

    func testCrossProduct() {
        let candidate = DVec3(x: 1, y: 0, z: 0)
        let testValues = [
            DVec3(x: 1, y: 0, z: 0),
            DVec3(x: -1, y: 0, z: 0),
            DVec3(x: 0, y: 1, z: 0),
            DVec3(x: 0, y: -1, z: 0),
            DVec3(x: 0, y: 0, z: 1),
            DVec3(x: 0, y: 0, z: -1),
        ]
        let expected = [
            DVec3(x: 0, y: 0, z: 0),
            DVec3(x: 0, y: 0, z: 0),
            DVec3(x: 0, y: 0, z: 1),
            DVec3(x: 0, y: 0, z: -1),
            DVec3(x: 0, y: -1, z: 0),
            DVec3(x: 0, y: 1, z: 0),
        ]
        let actual = testValues.map(candidate.cross)
        XCTAssertEqual(actual, expected, "Cross Product failed")
    }
}
