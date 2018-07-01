import XCTest
@testable import cchain_contracts_framework

final class cchain_contracts_frameworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(cchain_contracts_framework().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
