import XCTest
@testable import FlagsLib


final class FlagsLibTests: XCTestCase {
    func testExample() throws {
        let data = FlagsLib.getFlagData(byCountryTag: "pl")
        XCTAssertNotNil(data)
    }
}
