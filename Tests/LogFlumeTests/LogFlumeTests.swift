//
//  LogFlumeTests.swift
//  LogFlumeTests
//
//  Created by sangheon on 2023/04/24.
//

import XCTest
@testable import LogFlume

final class LogFlumeTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testAddChannel() throws {
        let log = LogFlume.self
        
        XCTAssertEqual(log.countChannels(), 0)
        
        let mainXcode = XcodeLoggingChannel()
        
        XCTAssertEqual(log.countChannels(), 0)
        XCTAssertTrue(log.addChannels(mainXcode))
        XCTAssertEqual(log.countChannels(), 1)
        
        let subXcode = XcodeLoggingChannel()
        
        XCTAssertFalse(log.addChannels(subXcode))
        XCTAssertEqual(log.countChannels(), 1)
    }

    func testRemoveChannel() throws {
        let log = LogFlume.self
        
        XCTAssertEqual(log.countChannels(), 0)
        
        // remove valid channels
        let xcode = XcodeLoggingChannel()
        
        // add channels
        XCTAssertTrue(log.addChannels(xcode))
        XCTAssertEqual(log.countChannels(), 1)
        
        // remove channels
        XCTAssertTrue(log.removeChannels(xcode))
        XCTAssertEqual(log.countChannels(), 0)
    }

}
