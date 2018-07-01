import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(cchain_contracts_frameworkTests.allTests),
    ]
}
#endif