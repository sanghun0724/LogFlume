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
        XCTAssertFalse(log.addChannels(mainXcode))
        XCTAssertEqual(log.countChannels(), 1)
        
        let subXcode = XcodeLoggingChannel()
        
        XCTAssertTrue(log.addChannels(subXcode))
        XCTAssertEqual(log.countChannels(), 2)
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


private class MockChannel: LoggingChannel {
    static func == (lhs: MockChannel, rhs: MockChannel) -> Bool {
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(mockLine)
    }
    
    var mockLevel: LogFlume.Level?
    var mockMessage: String?
    var mockThreadName: String?
    var mockFileName: String?
    var mockFunctionName: String?
    var mockLine: UInt?
    var mockValue: (Any?)?
    
    var queue: DispatchQueue = .main
    
    func sendLog(_ level: LogFlume.Level, fileName: String, line: UInt, funcName: String, threadName: String, message: String, printerType: LogFlume.PrinterType, targetValue: Any) -> String? {
        mockLevel = level
        mockMessage = message
        mockThreadName = threadName
        mockFileName = fileName
        mockFunctionName = funcName
        mockLine = line
        mockValue = targetValue
        
        return ""
    }
    
}
