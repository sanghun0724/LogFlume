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
    
    func testLoggingAllChannels() throws {
        let log = LogFlume.self
        
        let firstChannel = MockChannel()
        
        log.addChannels(firstChannel)
        
        log.excuteLogging(.info, fileName: "fileName", line: 18, funcName: "funcName", message: "message", printerType: .debug, targetValue: "targetValue")
        
        XCTAssertEqual(firstChannel.mockLevel, LogFlume.Level.info)
        
        XCTAssertEqual(firstChannel.mockFileName, "fileName")
        
        XCTAssertEqual(firstChannel.mockFunctionName, "funcName")
        
        XCTAssertEqual(firstChannel.mockPrinterType, .debug)
        
        XCTAssertEqual(firstChannel.mockMessage, "message")
        
        XCTAssertNotNil(firstChannel.mockValue)
        
    }
    
    func testLoggingWithoutChannel() {
        let log = LogFlume.self
        
        //log.verbose("Where do I log to?")
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
    var mockFileName: String?
    var mockFunctionName: String?
    var mockLine: UInt?
    var mockPrinterType: LogFlume.PrinterType?
    var mockValue: Any?
    
    var queue: DispatchQueue = .global()
    
    func sendLog(_ level: LogFlume.Level, fileName: String, line: UInt, funcName: String, message: String, printerType: LogFlume.PrinterType, targetValue: Any) -> String? {
        mockLevel = level
        mockMessage = message
        mockFileName = fileName
        mockFunctionName = funcName
        mockLine = line
        mockPrinterType = printerType
        mockValue = targetValue
        
        return ""
    }
    
}
