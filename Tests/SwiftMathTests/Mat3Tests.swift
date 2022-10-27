import XCTest

@testable import SwiftMath

class M3Tests: XCTestCase {
    func testInit() {
        let expected: [[Float]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let candidate = FMat3(FVec3(1,2,3), FVec3(4,5,6), FVec3(7,8,9))
        let actual: [[Float]] = candidate.data
        XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEquals() {
        let actual = FMat3(1.231999999).almostEquals(FMat3(1.232))
        XCTAssertTrue(actual, "Almost Equals failed")
    }

   func testTranspose() {
       let expected: [[Float]] = [
           [1.0, 3.0, 5.0],
           [2.0, 6.0, 10.0],
           [3.0, 9.0, 15.0],
       ]
       let actual = FMat3(
           FVec3(1.0, 2.0, 3.0),
           FVec3(3.0, 6.0, 9.0),
           FVec3(5.0, 10.0, 15.0)).transpose.data
       XCTAssertEqual(actual, expected, "Transpose failed")
   }

    func testInverse() {
        let expected = FMat3(1)
        let candidate = FMat3(
            [
                [3.0, 2.0, 3.0],
                [9.0, 6.0, 3.0],
                [6.0, 10.0, 13.0],
            ])
        let actual = candidate * candidate.inverse
        let result = actual.almostEquals(expected)
        XCTAssertTrue(result, "Inverse failed")
    }

    func testVectorMultiplication() {
        let expected = FVec3(1, 2, 3)
        let identityMatrix = FMat3(1)
        let candidate = FVec3(1, 2, 3)
        let actual: FVec3 = candidate * identityMatrix
        XCTAssertEqual(actual, expected, "Vector Multiplication failed")
    }

    func testMatrixMultiplication() {
        let matrixA = FMat3([
            [1.0, 2.0, 3.0],
            [5.0, 6.0, 7.0],
            [9.0, 10.0, 11.0],
        ])
        let matrixB = FMat3([
            [0.0, 3.0, 6.0],
            [12.0, 15.0, 18.0],
            [24.0, 27.0, 30.0],
        ])
        let expectedAxB = FMat3([
            [69.0, 78.0, 87.0],
            [249.0, 294.0, 339.0],
            [429.0, 510.0, 591.0],
        ])
        let expectedBxA = FMat3([
            [96.0, 114.0, 132.0],
            [240.0, 294.0, 348.0],
            [384.0, 474.0, 564.0],
        ])
        let actualAxB = matrixA * matrixB
        let actualBxA = matrixB * matrixA

        let resultAxB = expectedAxB == actualAxB
        let resultBxA = expectedBxA == actualBxA

        let result = resultAxB && resultBxA
        XCTAssertTrue(result, "Matrix Multiplication failed")
    }
}
