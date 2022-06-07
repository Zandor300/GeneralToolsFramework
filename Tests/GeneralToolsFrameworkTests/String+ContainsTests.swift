//
//  String+ContainsTests.swift
//  GeneralToolsFramework_Tests
//
//  Created by Zandor Smith on 19/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import GeneralToolsFramework

class StringContainsTests: XCTestCase {

    func testStringContains() {
        let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

        XCTAssertTrue(string.contains(find: "dolore"))
        XCTAssertFalse(string.contains(find: "Dolore"))
        XCTAssertFalse(string.contains(find: "test"))
    }

    func testStringContainsIgnoringCase() {
        let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

        XCTAssertTrue(string.containsIgnoringCase(find: "dolore"))
        XCTAssertTrue(string.containsIgnoringCase(find: "Dolore"))
        XCTAssertFalse(string.containsIgnoringCase(find: "test"))
    }

}
