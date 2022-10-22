import XCTest

@testable import SwiftMath

class M3Tests: XCTestCase {
    func testInit() {
        let expected: [Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let candidate = FM3([FV3(1,2,3), FV3(4,5,6), FV3(7,8,9)])
        let actual: [Float] = [candidate[0], candidate[1], candidate[2]].map{ (x: FV3) in
            x.flatten()
        }.flatMap { x in x }
        XCTAssertEqual(actual, expected, "Init failed")
    }
//
//    func testAlmostEquals() {
//        let actual = DMat3(1.231999999).almostEquals(DMat3(1.232))
//        XCTAssertTrue(actual, "Almost Equals failed")
//    }
//
//    func testTranspose() {
//        let expected: [[Double]] = [
//            [1.0, 3.0, 5.0],
//            [2.0, 6.0, 10.0],
//            [3.0, 9.0, 15.0],
//        ]
//        let actual = DMat3(
//            data: [
//                [1.0, 2.0, 3.0],
//                [3.0, 6.0, 9.0],
//                [5.0, 10.0, 15.0],
//                [7.0, 14.0, 21.0],
//            ]).transpose().data
//        XCTAssertEqual(actual, expected, "Transpose failed")
//    }
//
//    func testInverse() {
//        // edge case
//        // data: [
//        //     [1.0, 2.0, 3.0],
//        //     [3.0, 6.0, 9.0],
//        //     [5.0, 10.0, 15.0],
//        // ])
//        let expected = Mat3(1)
//        let candidate = DMat3(
//            data: [
//                [3.0, 2.0, 3.0],
//                [9.0, 6.0, 3.0],
//                [6.0, 10.0, 13.0],
//            ])
//        let actual = candidate * candidate.inverse()
//        let result = actual.almostEquals(expected)
//        XCTAssertTrue(result, "Inverse failed")
//    }
//
//    func testVectorMultiplication() {
//        let expected = DVec3(1, 2, 3)
//        let identityMatrix = DMat3(1)
//        let candidate = DVec3(1, 2, 3)
//        let actual = identityMatrix * candidate
//        XCTAssertEqual(actual, expected, "Vector Multiplication failed")
//    }
//
//    func testMatrixMultiplication() {
//        let matrixA = DMat3(data: [
//            [1.0, 2.0, 3.0],
//            [5.0, 6.0, 7.0],
//            [9.0, 10.0, 11.0],
//        ])
//        let matrixB = DMat3(data: [
//            [0.0, 3.0, 6.0],
//            [12.0, 15.0, 18.0],
//            [24.0, 27.0, 30.0],
//        ])
//        let expectedAxB = DMat3(data: [
//            [96.0, 114.0, 132.0],
//            [240.0, 294.0, 348.0],
//            [384.0, 474.0, 564.0],
//        ])
//        let expectedBxA = DMat3(data: [
//            [69.0, 78.0, 87.0],
//            [249.0, 294.0, 339.0],
//            [429.0, 510.0, 591.0],
//        ])
//        let actualAxB = matrixA * matrixB
//        let actualBxA = matrixB * matrixA
//
//        let resultAxB = expectedAxB == actualAxB
//        let resultBxA = expectedBxA == actualBxA
//
//        let result = resultAxB && resultBxA
//        XCTAssertTrue(result, "Matrix Multiplication failed")
//    }
//
//    func testRotatePositionVector() {
//        let expected = [
//            DVec3(1, 0, 0),
//            DVec3(0, 1, 0),
//            DVec3(0, 0, 1),
//            DVec3(-1, 0, 0),
//            DVec3(0, -1, 0),
//            DVec3(0, 0, -1),
//        ]
//        let angles = [
//            DVec3(0, Double.pi / 2, 0),
//            DVec3(0, 0, Double.pi / 2),
//            DVec3(Double.pi / 2, 0, 0),
//            DVec3(0, -Double.pi / 2, 0),
//            DVec3(0, 0, -Double.pi / 2),
//            DVec3(-Double.pi / 2, 0, 0),
//        ]
//        let candidates = [
//            DVec3(0, 0, 1),
//            DVec3(1, 0, 0),
//            DVec3(0, 1, 0),
//            DVec3(0, 0, 1),
//            DVec3(1, 0, 0),
//            DVec3(0, 1, 0),
//        ]
//        let result = (0..<candidates.count).reduce(true) { result, i in
//            let tMat = DMat3.rotation(angles[i])
//            let newResult = result && (expected[i].almostEquals(tMat * candidates[i]))
//            return newResult
//        }
//        XCTAssertTrue(result, "Rotate Position Vector failed")
//    }
//
//    func testRotateDirectionVector() {
//        let expected = [
//            DVec3(1, 0, 0),
//            DVec3(0, 1, 0),
//            DVec3(0, 0, 1),
//            DVec3(-1, 0, 0),
//            DVec3(0, -1, 0),
//            DVec3(0, 0, -1),
//        ]
//        let angles = [
//            DVec3(0, Double.pi / 2, 0),
//            DVec3(0, 0, Double.pi / 2),
//            DVec3(Double.pi / 2, 0, 0),
//            DVec3(0, -Double.pi / 2, 0),
//            DVec3(0, 0, -Double.pi / 2),
//            DVec3(-Double.pi / 2, 0, 0),
//        ]
//        let candidates = [
//            DVec3(0, 0, 1),
//            DVec3(1, 0, 0),
//            DVec3(0, 1, 0),
//            DVec3(0, 0, 1),
//            DVec3(1, 0, 0),
//            DVec3(0, 1, 0),
//        ]
//        let result = (0..<candidates.count).reduce(true) { result, i in
//            let tMat = DMat3.rotation(angles[i])
//            let newResult = result && (expected[i].almostEquals(tMat * candidates[i]))
//            return newResult
//        }
//        XCTAssertTrue(result, "Rotate Direction Vector failed")
//    }
//
//    func testScalePositionVector() {
//        let expected = [
//            DVec3(4, 2, 2),
//            DVec3(2, 4, 2),
//            DVec3(2, 2, 4),
//            DVec3(1, 2, 2),
//            DVec3(2, 1, 2),
//            DVec3(2, 2, 1),
//        ]
//        let scales = [
//            DVec3(2, 1, 1),
//            DVec3(1, 2, 1),
//            DVec3(1, 1, 2),
//            DVec3(0.5, 1, 1),
//            DVec3(1, 0.5, 1),
//            DVec3(1, 1, 0.5),
//        ]
//        let result = (0..<scales.count).reduce(true) { result, i in
//            let tMat = DMat3.scale(scales[i])
//            let newResult = result && (expected[i].almostEquals(tMat * DVec3(2, 2, 2)))
//            return newResult
//        }
//        XCTAssertTrue(result, "Scale Position Vector failed")
//    }
//
//    func testScaleDirectionVector() {
//        let expected = [
//            DVec3(4, 2, 2),
//            DVec3(2, 4, 2),
//            DVec3(2, 2, 4),
//            DVec3(1, 2, 2),
//            DVec3(2, 1, 2),
//            DVec3(2, 2, 1),
//        ]
//        let scales = [
//            DVec3(2, 1, 1),
//            DVec3(1, 2, 1),
//            DVec3(1, 1, 2),
//            DVec3(0.5, 1, 1),
//            DVec3(1, 0.5, 1),
//            DVec3(1, 1, 0.5),
//        ]
//        let result = (0..<scales.count).reduce(true) { result, i in
//            let tMat = DMat3.scale(scales[i])
//            let newResult = result && (expected[i].almostEquals(tMat * DVec3(2, 2, 2)))
//            return newResult
//        }
//        XCTAssertTrue(result, "Scale Direction Vector failed")
//    }
//
//    func testFlatten() {
//        let expected = [
//            0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0,
//        ]
//        let candidate = Mat3(data: [
//            [0.0, 1.0, 2.0],
//            [3.0, 4.0, 5.0],
//            [6.0, 7.0, 8.0],
//        ])
//        let actual = candidate.flatten()
//        XCTAssertEqual(actual, expected, "Flatten failed")
//    }
}
