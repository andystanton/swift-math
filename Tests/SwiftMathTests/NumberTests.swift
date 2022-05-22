import XCTest

class NumberTests: XCTestCase {
    func testAlmostEqualsDouble() throws {
        let candidate: Double = 1.231999999
        let actual = candidate.almostEquals(1.232)
        XCTAssertTrue(actual, "Almost Equals Double failed")
    }

    func testAlmostEqualsFloat() throws {
        let candidate: Float = 7.54979e-08
        let actual = candidate.almostEquals(0)
        XCTAssertTrue(actual, "Almost Equals Float failed")
    }
}
