import XCTest

import cchain_contracts_frameworkTests

var tests = [XCTestCaseEntry]()
tests += cchain_contracts_frameworkTests.allTests()
XCTMain(tests)