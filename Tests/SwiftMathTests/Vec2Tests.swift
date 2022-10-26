import XCTest

@testable import SwiftMath

class FVec2Tests: XCTestCase {
    func testInit() {
        let expected: [Float] = [1, 2]
        let candidate = FVec2(x: 1, y: 2)
        let actual = [candidate.x, candidate.y]
        XCTAssertEqual(actual, expected, "Init failed")
    }
    
    func testAlmostEqual() {
        XCTAssertTrue(FVec2(of: 1.231999999).almostEquals(FVec2(of: 1.232)), "Almost Equal failed")
        XCTAssertFalse(FVec2(of: 1.231).almostEquals(FVec2(of: 1.232)), "Almost Equal failed")
    }
    
    func testSubscriptAccess() {
        let candidate = FVec2(x: 1, y: 2)
        let expected: [Float] = [1, 2]
        let actual = [0, 1].map { candidate[$0] }
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }
    
    func testFlatten() {
        let candidate = FVec2(x: 1, y: 2)
        let expected: [Float] = [1, 2]
        let actual = candidate.data
        XCTAssertEqual(actual, expected, "Flatten Failed")
    }
    
    func testAxialUnitConstants() {
        let expected: [[Float]] = [
            [1, 0],
            [0, 1],
        ]
        let actual = [
            FVec2.xUnit,
            FVec2.yUnit,
        ].map { v in [v.x, v.y] }
        XCTAssertEqual(actual, expected, "Axial Units failed")
    }
    
    func testLength() {
        let expected: Float = 5
        let candidate = FVec2(x: 3, y: 4)
        let actual = candidate.len()
        XCTAssertEqual(actual, expected, "Length failed")
    }
    
    func testNormalise() {
        let expected = FVec2(of: (1 / 2).squareRoot())
        let candidate = FVec2(x: 1, y: 1)
        let actual = candidate.normalize()
        XCTAssertTrue(actual.almostEquals(expected), "Normalise failed")
    }
    
    func testUniformScale() {
        let expected = FVec2(x: 2, y: 4)
        let candidate = FVec2(x: 1, y: 2)
        let actual = candidate * 2
        XCTAssertTrue(actual.almostEquals(expected), "Uniform Scale failed")
    }
    
    func testNonUniformScale() {
        let expected = FVec2(x: 2, y: 6)
        let candidate = FVec2(x: 1, y: 2)
        let actual = candidate * FVec2(x: 2, y: 3)
        XCTAssertTrue(actual.almostEquals(expected), "Non-Uniform Scale failed")
    }
    
    func testUniformDivison() {
        let expected = FVec2(x: 1, y: 2)
        let candidate = FVec2(x: 2, y: 4)
        let actual = candidate / 2
        XCTAssertEqual(actual, expected, "Uniform Division failed")
    }
    
    func testNonUniformDivison() {
        let expected = FVec2(x: 1, y: 2)
        let candidate = FVec2(x: 2, y: 6)
        let actual = candidate / FVec2(x: 2, y: 3)
        XCTAssertEqual(actual, expected, "Non-Uniform Division failed")
    }
    
    func testAddition() {
        let expected = FVec2(x: 3, y: 5)
        let candidate = FVec2(x: 1, y: 2)
        let actual = candidate + FVec2(x: 2, y: 3)
        XCTAssertEqual(actual, expected, "Addition failed")
    }
    
    func testSubtraction() {
        let expected = FVec2(x: 1, y: 2)
        let candidate = FVec2(x: 3, y: 5)
        let actual = candidate - FVec2(x: 2, y: 3)
        XCTAssertEqual(actual, expected, "Subtraction failed")
    }
    
    func testDotProduct() {
        let candidate = FVec2(x: 1, y: 0)
        let testValues = [
            FVec2(x: 0, y: 0),
            FVec2(x: 1, y: 0),
            FVec2(x: -1, y: 0),
            FVec2(x: 0, y: 1),
            FVec2(x: 0, y: -1),
            FVec2(x: 0.5, y: 0.8660254038),
            FVec2(x: -0.5, y: -0.8660254038),
        ]
        let expected: [Float] = [
            0,
            1,
            -1,
            0,
            0,
            0.5,
            -0.5,
        ]
        let actual = testValues.map(candidate.dot)
        XCTAssertEqual(actual, expected, "Dot Product failed")
    }
}
