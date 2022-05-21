
import XCTest
@testable import SwiftMath

class DVec4Tests: XCTestCase {
    func testInit() {
       let expected: [Double] = [1, 2, 3, 4]
       let candidate = DVec4(x: 1, y: 2, z: 3, w: 4)
       let actual = [candidate.x, candidate.y, candidate.z, candidate.w]
       XCTAssertEqual(actual, expected, "Init failed")
    }
}
