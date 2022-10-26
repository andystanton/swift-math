import XCTest

@testable import SwiftMath
import simd

class M4Tests: XCTestCase {
    func testInit() {
        let expected: [[Float]] = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 15, 16]]
        let candidate = FMat4(
                FVec4(1, 2, 3, 4),
                FVec4(5, 6, 7, 8),
                FVec4(9, 10, 11, 12),
                FVec4(13, 14, 15, 16))
        let actual = candidate.data
        XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEquals() {
        let actual = FMat4(1.231999999).almostEquals(FMat4(1.232))
        XCTAssertTrue(actual, "Almost Equals failed")
    }

    func testTranspose() {
        let expected: [[Float]] = [
            [1.0, 3.0, 5.0, 7.0],
            [2.0, 6.0, 10.0, 14.0],
            [3.0, 9.0, 15.0, 21.0],
            [4.0, 12.0, 20.0, 28.0],
        ]
        let actual = FMat4(
                FVec4(1.0, 2.0, 3.0, 4.0),
                FVec4(3.0, 6.0, 9.0, 12.0),
                FVec4(5.0, 10.0, 15.0, 20.0),
                FVec4(7.0, 14.0, 21.0, 28.0)).transpose.data
        XCTAssertEqual(actual, expected, "Transpose failed")
    }

    func testVectorMultiplication() {
        let expected = FVec4(1, 2, 3, 4)
        let identityMatrix = FMat4(1)
        let candidate = FVec4(1, 2, 3, 4)
        let actual = candidate * identityMatrix
        XCTAssertEqual(actual, expected, "Vector Multiplication failed")
    }

    func testMatrixMultiplication() {
        let matrixA = FMat4(
            FVec4(1.0, 2.0, 3.0, 4.0),
            FVec4(5.0, 6.0, 7.0, 8.0),
            FVec4(9.0, 10.0, 11.0, 12.0),
            FVec4(13.0, 14.0, 15.0, 16.0))
        let matrixB = FMat4(
            FVec4(0.0, 3.0, 6.0, 9.0),
            FVec4(12.0, 15.0, 18.0, 21.0),
            FVec4(24.0, 27.0, 30.0, 33.0),
            FVec4(36.0, 39.0, 42.0, 45.0))
        let expectedAxB = FMat4(
            FVec4(186.0, 204.0, 222.0, 240.0),
            FVec4(522.0, 588.0, 654.0, 720.0),
            FVec4(858.0, 972.0, 1086.0, 1200.0),
            FVec4(1194.0, 1356.0, 1518.0, 1680.0))
        let expectedBxA = FMat4(
            FVec4(240.0, 270.0, 300.0, 330.0),
            FVec4(528.0, 606.0, 684.0, 762.0),
            FVec4(816.0, 942.0, 1068.0, 1194.0),
            FVec4(1104.0, 1278.0, 1452.0, 1626.0))
        let actualAxB = matrixA * matrixB
        let actualBxA = matrixB * matrixA

        let resultAxB = expectedAxB == actualAxB
        let resultBxA = expectedBxA == actualBxA

        let result = resultAxB && resultBxA
        XCTAssertTrue(result, "Matrix Multiplication failed")
    }

     func testTranslatePositionVector() {
         let expected = FVec4(5.0, 8.0, 6.0, 1.0)
         let tMat = FMat4.translation(FVec3(4.0, 6.0, 3.0))
         let candidate = FVec3(1.0, 2.0, 3.0).toPos()
         let actual = tMat * candidate
         XCTAssertEqual(actual, expected, "Translate Position Vector failed")
     }

     func testTranslateDirectionVectorHasNoEffect() {
         let expected = FVec4(1.0, 2.0, 3.0, 0.0)
         let tMat = FMat4.translation(FVec3(4.0, 6.0, 3.0))
         let candidate = FVec3(1.0, 2.0, 3.0).toDir()
         let actual = tMat * candidate
         XCTAssertEqual(actual, expected, "Translate Direction Vector failed")
     }

     func testRotatePositionVector() {
         let expected = [
             FVec4(1, 0, 0, 1),
             FVec4(0, 1, 0, 1),
             FVec4(0, 0, 1, 1),
             FVec4(-1, 0, 0, 1),
             FVec4(0, -1, 0, 1),
             FVec4(0, 0, -1, 1),
         ]
         let angles = [
             FVec3(0, Float.pi / 2, 0),
             FVec3(0, 0, Float.pi / 2),
             FVec3(Float.pi / 2, 0, 0),
             FVec3(0, -Float.pi / 2, 0),
             FVec3(0, 0, -Float.pi / 2),
             FVec3(-Float.pi / 2, 0, 0),
         ]
         let candidates = [
             FVec4(0, 0, 1, 1),
             FVec4(1, 0, 0, 1),
             FVec4(0, 1, 0, 1),
             FVec4(0, 0, 1, 1),
             FVec4(1, 0, 0, 1),
             FVec4(0, 1, 0, 1),
         ]
         let result = (0..<candidates.count).reduce(true) { result, i in
             let tMat = FMat4.rotation(angles[i])
             let newResult = (expected[i].almostEquals(candidates[i] * tMat))
             if !newResult {
                 print("\(expected[i]) did not equal \(candidates[i] * tMat)")
             }
             return result && newResult
         }
         XCTAssertTrue(result, "Rotate Position Vector failed")
     }

     func testRotateDirectionVector() {
         let expected = [
             FVec4(1, 0, 0, 0),
             FVec4(0, 1, 0, 0),
             FVec4(0, 0, 1, 0),
             FVec4(-1, 0, 0, 0),
             FVec4(0, -1, 0, 0),
             FVec4(0, 0, -1, 0),
         ]
         let angles = [
             FVec3(0, Float.pi / 2, 0),
             FVec3(0, 0, Float.pi / 2),
             FVec3(Float.pi / 2, 0, 0),
             FVec3(0, -Float.pi / 2, 0),
             FVec3(0, 0, -Float.pi / 2),
             FVec3(-Float.pi / 2, 0, 0),
         ]
         let candidates = [
             FVec4(0, 0, 1, 0),
             FVec4(1, 0, 0, 0),
             FVec4(0, 1, 0, 0),
             FVec4(0, 0, 1, 0),
             FVec4(1, 0, 0, 0),
             FVec4(0, 1, 0, 0),
         ]
         let result = (0..<candidates.count).reduce(true) { result, i in
             let tMat = FMat4.rotation(angles[i])
             let newResult = result && (expected[i].almostEquals(candidates[i] * tMat))
             return newResult
         }
         XCTAssertTrue(result, "Rotate Direction Vector failed")
     }

     func testScalePositionVector() {
         let expected = [
             FVec4(4, 2, 2, 1),
             FVec4(2, 4, 2, 1),
             FVec4(2, 2, 4, 1),
             FVec4(1, 2, 2, 1),
             FVec4(2, 1, 2, 1),
             FVec4(2, 2, 1, 1),
         ]
         let scales = [
             FVec3(2, 1, 1),
             FVec3(1, 2, 1),
             FVec3(1, 1, 2),
             FVec3(0.5, 1, 1),
             FVec3(1, 0.5, 1),
             FVec3(1, 1, 0.5),
         ]
         let result = (0..<scales.count).reduce(true) { result, i in
             let tMat = FMat4.scale(scales[i])
             let newResult = result && (expected[i].almostEquals(tMat * FVec4(2, 2, 2, 1)))
             return newResult
         }
         XCTAssertTrue(result, "Scale Position Vector failed")
     }

     func testScaleDirectionVector() {
         let expected = [
             FVec4(4, 2, 2, 0),
             FVec4(2, 4, 2, 0),
             FVec4(2, 2, 4, 0),
             FVec4(1, 2, 2, 0),
             FVec4(2, 1, 2, 0),
             FVec4(2, 2, 1, 0),
         ]
         let scales = [
             FVec3(2, 1, 1),
             FVec3(1, 2, 1),
             FVec3(1, 1, 2),
             FVec3(0.5, 1, 1),
             FVec3(1, 0.5, 1),
             FVec3(1, 1, 0.5),
         ]
         let result = (0..<scales.count).reduce(true) { result, i in
             let tMat = FMat4.scale(scales[i])
             let newResult = result && (expected[i].almostEquals(tMat * FVec4(2, 2, 2, 0)))
             return newResult
         }
         XCTAssertTrue(result, "Scale Direction Vector failed")
     }

     func testFlatten() {
         let expected: [Float] = [
             0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0,
         ]
         let candidate = FMat4(
             FVec4(0.0, 1.0, 2.0, 3.0),
             FVec4(4.0, 5.0, 6.0, 7.0),
             FVec4(8.0, 9.0, 10.0, 11.0),
             FVec4(12.0, 13.0, 14.0, 15.0))
         let actual = candidate.flatten
         XCTAssertEqual(actual, expected, "Flatten failed")
     }

     func testToMat3() {
         let expected = FMat3(
             FVec3(0.0, 1.0, 2.0),
             FVec3(4.0, 5.0, 6.0),
             FVec3(8.0, 9.0, 10.0))
         let candidate = FMat4(
             FVec4(0.0, 1.0, 2.0, 3.0),
             FVec4(4.0, 5.0, 6.0, 7.0),
             FVec4(8.0, 9.0, 10.0, 11.0),
             FVec4(12.0, 13.0, 14.0, 15.0))
         let result = candidate.toMat3().almostEquals(expected)
         XCTAssertTrue(result, "toFMat3 failed")
     }
}
