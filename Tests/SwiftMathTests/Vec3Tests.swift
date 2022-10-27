import XCTest

@testable import SwiftMath

class FVec3Tests: XCTestCase {
    func testInit() {
        let expected: [Float] = [1, 2, 3]
        let candidate = FVec3(x: 1, y: 2, z: 3)
        let actual = [candidate.x, candidate.y, candidate.z]
        XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEqual() {
        XCTAssertTrue(FVec3(of: 1.231999999).almostEquals(FVec3(of: 1.232)), "Almost Equal failed")
        XCTAssertFalse(FVec3(of: 1.231).almostEquals(FVec3(of: 1.232)), "Almost Equal failed")
    }

    func testSubscriptAccess() {
        let candidate = FVec3(x: 1, y: 2, z: 3)
        let expected: [Float] = [1, 2, 3]
        let actual = [0, 1, 2].map { candidate[$0] }
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }

    func testFlatten() {
        let candidate = FVec3(x: 1, y: 2, z: 3)
        let expected: [Float] = [1, 2, 3]
        let actual = candidate.data
        XCTAssertEqual(actual, expected, "Flatten Failed")
    }

    func testAxialUnitConstants() {
        let expected: [[Float]] = [
            [1, 0, 0],
            [0, 1, 0],
            [0, 0, 1],
        ]
        let actual = [
            FVec3.xUnit,
            FVec3.yUnit,
            FVec3.zUnit,
        ].map { v in [v.x, v.y, v.z] }
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }

    func testLength() {
        let expected: Float = 7
        let candidate = FVec3(x: 2, y: 3, z: 6)
        let actual = candidate.len()
        XCTAssertEqual(actual, expected, "Length failed")
    }

    func testNormalise() {
        let expected = FVec3(of: (1 / 3).squareRoot())
        let candidate = FVec3(x: 1, y: 1, z: 1)
        let actual = candidate.normalize()
        XCTAssertTrue(actual.almostEquals(expected), "Normalise failed")
    }


    func testUniformScale() {
        let expected = FVec3(x: 2, y: 4, z: 6)
        let candidate = FVec3(x: 1, y: 2, z: 3)
        let actual = candidate * 2
        XCTAssertTrue(actual.almostEquals(expected), "Uniform Scale failed")
    }

    func testNonUniformScale() {
        let expected = FVec3(x: 2, y: 6, z: 12)
        let candidate = FVec3(x: 1, y: 2, z: 3)
        let actual = candidate * FVec3(x: 2, y: 3, z: 4)
        XCTAssertTrue(actual.almostEquals(expected), "Non-Uniform Scale failed")
    }

    func testUniformDivison() {
        let expected = FVec3(x: 1, y: 2, z: 3)
        let candidate = FVec3(x: 2, y: 4, z: 6)
        let actual = candidate / 2
        XCTAssertEqual(actual, expected, "Uniform Division failed")
    }

    func testNonUniformDivison() {
        let expected = FVec3(x: 1, y: 2, z: 3)
        let candidate = FVec3(x: 2, y: 6, z: 12)
        let actual = candidate / FVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Non-Uniform Division failed")
    }

    func testAddition() {
        let expected = FVec3(x: 3, y: 5, z: 7)
        let candidate = FVec3(x: 1, y: 2, z: 3)
        let actual = candidate + FVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Addition failed")
    }

    func testSubtraction() {
        let expected = FVec3(x: 1, y: 2, z: 3)
        let candidate = FVec3(x: 3, y: 5, z: 7)
        let actual = candidate - FVec3(x: 2, y: 3, z: 4)
        XCTAssertEqual(actual, expected, "Subtraction failed")
    }

    func testDotProduct() {
        let candidate = FVec3(x: 1, y: 0, z: 0)
        let testValues = [
            FVec3(x: 1, y: 0, z: 0),
            FVec3(x: -1, y: 0, z: 0),
            FVec3(x: 0, y: 1, z: 0),
            FVec3(x: 0, y: -1, z: 0),
            FVec3(x: 0, y: 0, z: 1),
            FVec3(x: 0, y: 0, z: -1),
            FVec3(x: 0.5, y: 0.8660254038, z: 0),
            FVec3(x: -0.5, y: -0.8660254038, z: 0),
        ]
        let expected: [Float] = [
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
        let candidate = FVec3(x: 1, y: 0, z: 0)
        let testValues: [FVec3] = [
            FVec3(x: 1, y: 0, z: 0),
            FVec3(x: -1, y: 0, z: 0),
            FVec3(x: 0, y: 1, z: 0),
            FVec3(x: 0, y: -1, z: 0),
            FVec3(x: 0, y: 0, z: 1),
            FVec3(x: 0, y: 0, z: -1),
        ]
        let expected: [FVec3] = [
            FVec3(x: 0, y: 0, z: 0),
            FVec3(x: 0, y: 0, z: 0),
            FVec3(x: 0, y: 0, z: 1),
            FVec3(x: 0, y: 0, z: -1),
            FVec3(x: 0, y: -1, z: 0),
            FVec3(x: 0, y: 1, z: 0),
        ]
        let actual = testValues.map(candidate.cross)
        XCTAssertEqual(actual, expected, "Cross Product failed")
    }
}
