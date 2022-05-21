import XCTest

@testable import SwiftMath

class DVec4Tests: XCTestCase {
    func testInit() {
        let expected: [Double] = [1, 2, 3, 4]
        let candidate = DVec4(x: 1, y: 2, z: 3, w: 4)
        let actual = [candidate.x, candidate.y, candidate.z, candidate.w]
        XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAxialUnitConstants() {
        let expected: [[Double]] = [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1],
        ]
        let actual = [
            DVec4.xUnit,
            DVec4.yUnit,
            DVec4.zUnit,
            DVec4.wUnit,
        ].map { v in [v.x, v.y, v.z, v.w] }
        XCTAssertEqual(actual, expected, "Axial Unit Constants failed")
    }

    func testSubvector() {
        let expected = DVec3(x: 1.0, y: 2.0, z: 3.0)
        let actual = DVec4(1.0, 2.0, 3.0, 4.0).xyz
        XCTAssertEqual(actual, expected, "Subvector failed")
    }
}
