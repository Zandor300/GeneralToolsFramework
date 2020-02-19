//
//  Float+RoundTests.swift
//  GeneralToolsFramework_Tests
//
//  Created by Zandor Smith on 19/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import GeneralToolsFramework

class FloatRoundTests: XCTestCase {

    func testRoundToPlaces() {
        let startFloat: Float = 1.23456789

        XCTAssertEqual(startFloat.roundToPlaces(0), 1.0)
        XCTAssertEqual(startFloat.roundToPlaces(1), 1.2)
        XCTAssertEqual(startFloat.roundToPlaces(2), 1.23)
        XCTAssertEqual(startFloat.roundToPlaces(3), 1.235)
        XCTAssertEqual(startFloat.roundToPlaces(4), 1.2346)
        XCTAssertEqual(startFloat.roundToPlaces(5), 1.23457)
        XCTAssertEqual(startFloat.roundToPlaces(6), 1.234568)
        XCTAssertEqual(startFloat.roundToPlaces(7), 1.2345679)
        XCTAssertEqual(startFloat.roundToPlaces(8), 1.23456789)
    }

    func testRoundToPlacesPositiveDown() {
        let startFloat: Float = 1.111111111

        XCTAssertEqual(startFloat.roundToPlaces(0), 1.0)
        XCTAssertEqual(startFloat.roundToPlaces(1), 1.1)
        XCTAssertEqual(startFloat.roundToPlaces(2), 1.11)
        XCTAssertEqual(startFloat.roundToPlaces(3), 1.111)
        XCTAssertEqual(startFloat.roundToPlaces(4), 1.1111)
        XCTAssertEqual(startFloat.roundToPlaces(5), 1.11111)
        XCTAssertEqual(startFloat.roundToPlaces(6), 1.111111)
        //XCTAssertEqual(startFloat.roundToPlaces(7), 1.1111111)
        XCTAssertEqual(startFloat.roundToPlaces(8), 1.11111111)
    }

    func testRoundToPlacesPositiveUp() {
        let startFloat: Float = 8.88888888888

        XCTAssertEqual(startFloat.roundToPlaces(0), 9)
        XCTAssertEqual(startFloat.roundToPlaces(1), 8.9)
        XCTAssertEqual(startFloat.roundToPlaces(2), 8.89)
        XCTAssertEqual(startFloat.roundToPlaces(3), 8.889)
        XCTAssertEqual(startFloat.roundToPlaces(4), 8.8889)
        XCTAssertEqual(startFloat.roundToPlaces(5), 8.88889)
        XCTAssertEqual(startFloat.roundToPlaces(6), 8.888889)
        XCTAssertEqual(startFloat.roundToPlaces(7), 8.8888889)
        XCTAssertEqual(startFloat.roundToPlaces(8), 8.88888889)
    }

    func testRoundToPlacesNegativeDown() {
        let startFloat: Float = -1.111111111

        XCTAssertEqual(startFloat.roundToPlaces(0), -1.0)
        XCTAssertEqual(startFloat.roundToPlaces(1), -1.1)
        XCTAssertEqual(startFloat.roundToPlaces(2), -1.11)
        XCTAssertEqual(startFloat.roundToPlaces(3), -1.111)
        XCTAssertEqual(startFloat.roundToPlaces(4), -1.1111)
        XCTAssertEqual(startFloat.roundToPlaces(5), -1.11111)
        XCTAssertEqual(startFloat.roundToPlaces(6), -1.111111)
        //XCTAssertEqual(startFloat.roundToPlaces(7), -1.1111111)
        XCTAssertEqual(startFloat.roundToPlaces(8), -1.11111111)
    }

    func testRoundToPlacesNegativeUp() {
        let startFloat: Float = -8.88888888888

        XCTAssertEqual(startFloat.roundToPlaces(0), -9)
        XCTAssertEqual(startFloat.roundToPlaces(1), -8.9)
        XCTAssertEqual(startFloat.roundToPlaces(2), -8.89)
        XCTAssertEqual(startFloat.roundToPlaces(3), -8.889)
        XCTAssertEqual(startFloat.roundToPlaces(4), -8.8889)
        XCTAssertEqual(startFloat.roundToPlaces(5), -8.88889)
        XCTAssertEqual(startFloat.roundToPlaces(6), -8.888889)
        XCTAssertEqual(startFloat.roundToPlaces(7), -8.8888889)
        XCTAssertEqual(startFloat.roundToPlaces(8), -8.88888889)
    }

}
