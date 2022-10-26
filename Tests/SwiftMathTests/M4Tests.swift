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
        let candidate = FM4(
                FV4(1, 2, 3, 4),
                FV4(5, 6, 7, 8),
                FV4(9, 10, 11, 12),
                FV4(13, 14, 15, 16))
        let actual = candidate.data
        XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEquals() {
        let actual = FM4(1.231999999).almostEquals(FM4(1.232))
        XCTAssertTrue(actual, "Almost Equals failed")
    }

    func testTranspose() {
        let expected: [[Float]] = [
            [1.0, 3.0, 5.0, 7.0],
            [2.0, 6.0, 10.0, 14.0],
            [3.0, 9.0, 15.0, 21.0],
            [4.0, 12.0, 20.0, 28.0],
        ]
        let actual = FM4(
                FV4(1.0, 2.0, 3.0, 4.0),
                FV4(3.0, 6.0, 9.0, 12.0),
                FV4(5.0, 10.0, 15.0, 20.0),
                FV4(7.0, 14.0, 21.0, 28.0)).transpose.data
        XCTAssertEqual(actual, expected, "Transpose failed")
    }

    func testVectorMultiplication() {
        let expected = FV4(1, 2, 3, 4)
        let identityMatrix = FM4(1)
        let candidate = FV4(1, 2, 3, 4)
        let actual = candidate * identityMatrix
        XCTAssertEqual(actual, expected, "Vector Multiplication failed")
    }

    func testMatrixMultiplication() {
        let matrixA = FM4(
            FV4(1.0, 2.0, 3.0, 4.0),
            FV4(5.0, 6.0, 7.0, 8.0),
            FV4(9.0, 10.0, 11.0, 12.0),
            FV4(13.0, 14.0, 15.0, 16.0))
        let matrixB = FM4(
            FV4(0.0, 3.0, 6.0, 9.0),
            FV4(12.0, 15.0, 18.0, 21.0),
            FV4(24.0, 27.0, 30.0, 33.0),
            FV4(36.0, 39.0, 42.0, 45.0))
        let expectedAxB = FM4(
            FV4(186.0, 204.0, 222.0, 240.0),
            FV4(522.0, 588.0, 654.0, 720.0),
            FV4(858.0, 972.0, 1086.0, 1200.0),
            FV4(1194.0, 1356.0, 1518.0, 1680.0))
        let expectedBxA = FM4(
            FV4(240.0, 270.0, 300.0, 330.0),
            FV4(528.0, 606.0, 684.0, 762.0),
            FV4(816.0, 942.0, 1068.0, 1194.0),
            FV4(1104.0, 1278.0, 1452.0, 1626.0))
        let actualAxB = matrixA * matrixB
        let actualBxA = matrixB * matrixA

        let resultAxB = expectedAxB == actualAxB
        let resultBxA = expectedBxA == actualBxA

        let result = resultAxB && resultBxA
        XCTAssertTrue(result, "Matrix Multiplication failed")
    }

     func testTranslatePositionVector() {
         let expected = FV4(5.0, 8.0, 6.0, 1.0)
         let tMat = FM4.translation(FV3(4.0, 6.0, 3.0))
         let candidate = FV3(1.0, 2.0, 3.0).toPos()
         let actual = tMat * candidate
         XCTAssertEqual(actual, expected, "Translate Position Vector failed")
     }

     func testTranslateDirectionVectorHasNoEffect() {
         let expected = FV4(1.0, 2.0, 3.0, 0.0)
         let tMat = FM4.translation(FV3(4.0, 6.0, 3.0))
         let candidate = FV3(1.0, 2.0, 3.0).toDir()
         let actual = tMat * candidate
         XCTAssertEqual(actual, expected, "Translate Direction Vector failed")
     }

     func testRotatePositionVector() {
         let expected = [
             FV4(1, 0, 0, 1),
             FV4(0, 1, 0, 1),
             FV4(0, 0, 1, 1),
             FV4(-1, 0, 0, 1),
             FV4(0, -1, 0, 1),
             FV4(0, 0, -1, 1),
         ]
         let angles = [
             FV3(0, Float.pi / 2, 0),
             FV3(0, 0, Float.pi / 2),
             FV3(Float.pi / 2, 0, 0),
             FV3(0, -Float.pi / 2, 0),
             FV3(0, 0, -Float.pi / 2),
             FV3(-Float.pi / 2, 0, 0),
         ]
         let candidates = [
             FV4(0, 0, 1, 1),
             FV4(1, 0, 0, 1),
             FV4(0, 1, 0, 1),
             FV4(0, 0, 1, 1),
             FV4(1, 0, 0, 1),
             FV4(0, 1, 0, 1),
         ]
         let result = (0..<candidates.count).reduce(true) { result, i in
             let tMat = FM4.rotation(angles[i])
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
             FV4(1, 0, 0, 0),
             FV4(0, 1, 0, 0),
             FV4(0, 0, 1, 0),
             FV4(-1, 0, 0, 0),
             FV4(0, -1, 0, 0),
             FV4(0, 0, -1, 0),
         ]
         let angles = [
             FV3(0, Float.pi / 2, 0),
             FV3(0, 0, Float.pi / 2),
             FV3(Float.pi / 2, 0, 0),
             FV3(0, -Float.pi / 2, 0),
             FV3(0, 0, -Float.pi / 2),
             FV3(-Float.pi / 2, 0, 0),
         ]
         let candidates = [
             FV4(0, 0, 1, 0),
             FV4(1, 0, 0, 0),
             FV4(0, 1, 0, 0),
             FV4(0, 0, 1, 0),
             FV4(1, 0, 0, 0),
             FV4(0, 1, 0, 0),
         ]
         let result = (0..<candidates.count).reduce(true) { result, i in
             let tMat = FM4.rotation(angles[i])
             let newResult = result && (expected[i].almostEquals(candidates[i] * tMat))
             return newResult
         }
         XCTAssertTrue(result, "Rotate Direction Vector failed")
     }

//     func testScalePositionVector() {
//         let expected = [
//             DVec4(4, 2, 2, 1),
//             DVec4(2, 4, 2, 1),
//             DVec4(2, 2, 4, 1),
//             DVec4(1, 2, 2, 1),
//             DVec4(2, 1, 2, 1),
//             DVec4(2, 2, 1, 1),
//         ]
//         let scales = [
//             DVec3(2, 1, 1),
//             DVec3(1, 2, 1),
//             DVec3(1, 1, 2),
//             DVec3(0.5, 1, 1),
//             DVec3(1, 0.5, 1),
//             DVec3(1, 1, 0.5),
//         ]
//         let result = (0..<scales.count).reduce(true) { result, i in
//             let tMat = DMat4.scale(scales[i])
//             let newResult = result && (expected[i].almostEquals(tMat * DVec4(2, 2, 2, 1)))
//             return newResult
//         }
//         XCTAssertTrue(result, "Scale Position Vector failed")
//     }

//     func testScaleDirectionVector() {
//         let expected = [
//             DVec4(4, 2, 2, 0),
//             DVec4(2, 4, 2, 0),
//             DVec4(2, 2, 4, 0),
//             DVec4(1, 2, 2, 0),
//             DVec4(2, 1, 2, 0),
//             DVec4(2, 2, 1, 0),
//         ]
//         let scales = [
//             DVec3(2, 1, 1),
//             DVec3(1, 2, 1),
//             DVec3(1, 1, 2),
//             DVec3(0.5, 1, 1),
//             DVec3(1, 0.5, 1),
//             DVec3(1, 1, 0.5),
//         ]
//         let result = (0..<scales.count).reduce(true) { result, i in
//             let tMat = DMat4.scale(scales[i])
//             let newResult = result && (expected[i].almostEquals(tMat * DVec4(2, 2, 2, 0)))
//             return newResult
//         }
//         XCTAssertTrue(result, "Scale Direction Vector failed")
//     }

//     func testFlatten() {
//         let expected = [
//             0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0,
//         ]
//         let candidate = Mat4(data: [
//             [0.0, 1.0, 2.0, 3.0],
//             [4.0, 5.0, 6.0, 7.0],
//             [8.0, 9.0, 10.0, 11.0],
//             [12.0, 13.0, 14.0, 15.0],
//         ])
//         let actual = candidate.flatten()
//         XCTAssertEqual(actual, expected, "Flatten failed")
//     }

//     func testToMat3() {
//         let expected = Mat3(data: [
//             [0.0, 1.0, 2.0],
//             [4.0, 5.0, 6.0],
//             [8.0, 9.0, 10.0],
//             [12.0, 13.0, 14.0],
//         ])
//         let candidate = Mat4(data: [
//             [0.0, 1.0, 2.0, 3.0],
//             [4.0, 5.0, 6.0, 7.0],
//             [8.0, 9.0, 10.0, 11.0],
//             [12.0, 13.0, 14.0, 15.0],
//         ])
//         let result = candidate.toMat3().almostEquals(expected)
//         XCTAssertTrue(result, "toMat3 failed")
//     }
}
