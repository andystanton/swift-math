import XCTest
@testable import SwiftMath

class Vec3Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testInit() {
       let expected: [Double] = [1.0, 2.0, 3.0]
       let candidate = DVec3(x: 1.0, y: 2.0, z: 3.0)
       let actual = [candidate.x, candidate.y, candidate.z]
       XCTAssertEqual(actual, expected, "Init failed")
    }

    func testAlmostEqual() {
        XCTAssertTrue(DVec3(1.231999999).almostEquals(DVec3(1.232)), "Almost Equal failed")
    }
}
