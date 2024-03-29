import XCTest

@testable import SwiftMath

class FVec4Tests: XCTestCase {
    func testInit() {
        let expected: [Float] = [1, 2, 3, 4]
        let candidate = FVec4(x: 1, y: 2, z: 3, w: 4)
        let actual = [candidate.x, candidate.y, candidate.z, candidate.w]
        XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEqual() {
        XCTAssertTrue(FVec4(of: 1.231999999).almostEquals(FVec4(of: 1.232)), "Almost Equal failed")
        XCTAssertFalse(FVec4(of: 1.231).almostEquals(FVec4(of: 1.232)), "Almost Equal failed")
    }

    func testSubscriptAccess() {
        let candidate = FVec4(x: 1, y: 2, z: 3, w: 4)
        let expected: [Float] = [1, 2, 3, 4]
        let actual = [0, 1, 2, 3].map { candidate[$0] }
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }

    func testFlatten() {
        let candidate = FVec4(x: 1, y: 2, z: 3, w: 4)
        let expected: [Float] = [1, 2, 3, 4]
        let actual = candidate.data
        XCTAssertEqual(actual, expected, "Flatten Failed")
    }

    func testAxialUnitConstants() {
        let expected: [[Float]] = [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1],
        ]
        let actual = [
            FVec4.xUnit,
            FVec4.yUnit,
            FVec4.zUnit,
            FVec4.wUnit,
        ].map { v in [v.x, v.y, v.z, v.w] }
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }

    func testLength() {
        let expected: Float = 9
        let candidate = FVec4(x: 2, y: 4, z: 5, w: 6)
        let actual = candidate.len()
        XCTAssertEqual(actual, expected, "Length failed")
    }

    func testNormalise() {
        let expected = FVec4(of: (1 / 4).squareRoot())
        let candidate = FVec4(x: 1, y: 1, z: 1, w: 1)
        let actual = candidate.normalize()
        XCTAssertTrue(actual.almostEquals(expected), "Normalise failed")
    }


    func testUniformScale() {
        let expected = FVec4(x: 2, y: 4, z: 6, w: 8)
        let candidate = FVec4(x: 1, y: 2, z: 3, w: 4)
        let actual = candidate * 2
        XCTAssertTrue(actual.almostEquals(expected), "Uniform Scale failed")
    }

    func testNonUniformScale() {
        let expected = FVec4(x: 2, y: 6, z: 12, w: 20)
        let candidate = FVec4(x: 1, y: 2, z: 3, w: 4)
        let actual = candidate * FVec4(x: 2, y: 3, z: 4, w: 5)
        XCTAssertTrue(actual.almostEquals(expected), "Non-Uniform Scale failed")
    }

    func testUniformDivison() {
        let expected = FVec4(x: 1, y: 2, z: 3, w: 4)
        let candidate = FVec4(x: 2, y: 4, z: 6, w: 8)
        let actual = candidate / 2
        XCTAssertEqual(actual, expected, "Uniform Division failed")
    }

    func testNonUniformDivison() {
        let expected = FVec4(x: 1, y: 2, z: 3, w: 4)
        let candidate = FVec4(x: 2, y: 6, z: 12, w: 20)
        let actual = candidate / FVec4(x: 2, y: 3, z: 4, w: 5)
        XCTAssertEqual(actual, expected, "Non-Uniform Division failed")
    }

    func testAddition() {
        let expected = FVec4(x: 3, y: 5, z: 7, w: 9)
        let candidate = FVec4(x: 1, y: 2, z: 3, w: 4)
        let actual = candidate + FVec4(x: 2, y: 3, z: 4, w: 5)
        XCTAssertEqual(actual, expected, "Addition failed")
    }

    func testSubtraction() {
        let expected = FVec4(x: 1, y: 2, z: 3, w: 4)
        let candidate = FVec4(x: 3, y: 5, z: 7, w: 9)
        let actual = candidate - FVec4(x: 2, y: 3, z: 4, w: 5)
        XCTAssertEqual(actual, expected, "Subtraction failed")
    }
}
