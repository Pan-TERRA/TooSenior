import XCTest

@testable import TooFoundation

final class CollectionSafeAccessTests: XCTestCase {
    func testSafeAccessWithinBounds() {
        let array = [10, 20, 30]
        XCTAssertEqual(array[safe: 0], 10)
        XCTAssertEqual(array[safe: 2], 30)
    }

    func testSafeAccessOutOfBounds() {
        let array = [1, 2, 3]
        XCTAssertNil(array[safe: -1])
        XCTAssertNil(array[safe: 3])
        XCTAssertNil(array[safe: 100])
    }

    func testSafeAccessEmptyArray() {
        let array: [Int] = []
        XCTAssertNil(array[safe: 0])
    }
}
