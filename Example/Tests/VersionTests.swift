//
//  Version.swift
//  GeneralToolsFramework_Tests
//
//  Created by Zandor Smith on 10/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import GeneralToolsFramework

class VersionTests: XCTestCase {

    func testVersionCompareEqual() {
        let lower = Version("1.2.5-1")
        let higher = Version("1.2.5-1")

        let invalidMessage = "\(lower.toString()) vs \(higher.toString()) failed"
        XCTAssertEqual(lower, higher, invalidMessage)
        XCTAssertTrue(lower >= higher, invalidMessage)
        XCTAssertTrue(lower <= higher, invalidMessage)
    }

    func testVersionCompareMajor() {
        let lower = Version("1.2.5-1")
        let higher = Version("2.2.5-1")

        let invalidMessage = "\(lower.toString()) vs \(higher.toString()) failed"
        XCTAssertNotEqual(lower, higher, invalidMessage)
        XCTAssertTrue(lower < higher, invalidMessage)
        XCTAssertTrue(lower <= higher, invalidMessage)
        XCTAssertFalse(lower > higher, invalidMessage)
        XCTAssertFalse(lower >= higher, invalidMessage)
        XCTAssertFalse(higher < lower, invalidMessage)
        XCTAssertFalse(higher <= lower, invalidMessage)
        XCTAssertTrue(higher > lower, invalidMessage)
        XCTAssertTrue(higher >= lower, invalidMessage)

        XCTAssertEqual(lower.compare(with: higher), VersionComparison.higher)
        XCTAssertEqual(higher.compare(with: lower), VersionComparison.lower)
    }

    func testVersionCompareMinor() {
        let lower = Version("1.2.5-1")
        let higher = Version("1.3.5-1")

        let invalidMessage = "\(lower.toString()) vs \(higher.toString()) failed"
        XCTAssertNotEqual(lower, higher, invalidMessage)
        XCTAssertTrue(lower < higher, invalidMessage)
        XCTAssertTrue(lower <= higher, invalidMessage)
        XCTAssertFalse(lower > higher, invalidMessage)
        XCTAssertFalse(lower >= higher, invalidMessage)
        XCTAssertFalse(higher < lower, invalidMessage)
        XCTAssertFalse(higher <= lower, invalidMessage)
        XCTAssertTrue(higher > lower, invalidMessage)
        XCTAssertTrue(higher >= lower, invalidMessage)

        XCTAssertEqual(lower.compare(with: higher), VersionComparison.higher)
        XCTAssertEqual(higher.compare(with: lower), VersionComparison.lower)
    }

    func testVersionComparePatch() {
        let lower = Version("1.2.5-1")
        let higher = Version("1.2.6-1")

        let invalidMessage = "\(lower.toString()) vs \(higher.toString()) failed"
        XCTAssertNotEqual(lower, higher, invalidMessage)
        XCTAssertTrue(lower < higher, invalidMessage)
        XCTAssertTrue(lower <= higher, invalidMessage)
        XCTAssertFalse(lower > higher, invalidMessage)
        XCTAssertFalse(lower >= higher, invalidMessage)
        XCTAssertFalse(higher < lower, invalidMessage)
        XCTAssertFalse(higher <= lower, invalidMessage)
        XCTAssertTrue(higher > lower, invalidMessage)
        XCTAssertTrue(higher >= lower, invalidMessage)

        XCTAssertEqual(lower.compare(with: higher), VersionComparison.higher)
        XCTAssertEqual(higher.compare(with: lower), VersionComparison.lower)
    }

    func testVersionCompareBuild() {
        let lower = Version("1.2.5-1")
        let higher = Version("1.2.5-2")

        let invalidMessage = "\(lower.toString()) vs \(higher.toString()) failed"
        XCTAssertNotEqual(lower, higher, invalidMessage)
        XCTAssertTrue(lower < higher, invalidMessage)
        XCTAssertTrue(lower <= higher, invalidMessage)
        XCTAssertFalse(lower > higher, invalidMessage)
        XCTAssertFalse(lower >= higher, invalidMessage)
        XCTAssertFalse(higher < lower, invalidMessage)
        XCTAssertFalse(higher <= lower, invalidMessage)
        XCTAssertTrue(higher > lower, invalidMessage)
        XCTAssertTrue(higher >= lower, invalidMessage)

        XCTAssertEqual(lower.compare(with: higher), VersionComparison.higher)
        XCTAssertEqual(higher.compare(with: lower), VersionComparison.lower)
    }

    func testVersionCompareAll() {
        let lower = Version("1.2.5-1")
        let higher = Version("2.3.6-2")

        let invalidMessage = "\(lower.toString()) vs \(higher.toString()) failed"
        XCTAssertNotEqual(lower, higher, invalidMessage)
        XCTAssertTrue(lower < higher, invalidMessage)
        XCTAssertTrue(lower <= higher, invalidMessage)
        XCTAssertFalse(lower > higher, invalidMessage)
        XCTAssertFalse(lower >= higher, invalidMessage)
        XCTAssertFalse(higher < lower, invalidMessage)
        XCTAssertFalse(higher <= lower, invalidMessage)
        XCTAssertTrue(higher > lower, invalidMessage)
        XCTAssertTrue(higher >= lower, invalidMessage)

        XCTAssertEqual(lower.compare(with: higher), VersionComparison.higher)
        XCTAssertEqual(higher.compare(with: lower), VersionComparison.lower)
    }

}
