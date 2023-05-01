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
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        let _ = LogFlume.removeAllChannels()
        try super.tearDownWithError()
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
        
        log.executeLoggingWithTargetValue(.info, fileName: "fileName", line: 18, funcName: "funcName", message: "message", printerType: .debug, targetValue: "targetValue")
        
        XCTAssertEqual(firstChannel.mockLevel, LogFlume.Level.info)
        
        XCTAssertEqual(firstChannel.mockFileName, "fileName")
        
        XCTAssertEqual(firstChannel.mockFunctionName, "funcName")
        
        XCTAssertEqual(firstChannel.mockPrinterType, .debug)
        
        XCTAssertEqual(firstChannel.mockMessage, "message")
        
        XCTAssertNotNil(firstChannel.mockValue)
    
    }
    
    
    func testLoggingWithoutChannel() {
        let log = LogFlume.self
        
        log.verbose("What Can I Do?")
        log.info("What Can I Do?", value: [123124123])
    }
    
    func testSimpleLoggingWithValue() {
        let log = LogFlume.self
        log.formatType = .complete
        log.dateFormat = "HH:mm"
        let xcode = XcodeLoggingChannel()
        XCTAssertTrue(log.addChannels(xcode))
        
        
        // default simple logging
        log.verbose("SHLEE is Pulple",printerType: .dump, value: [2,2,2,2,23,3,4])
        log.verbose(123, value: "Char")
        
        struct TestStruct { let val = 1 }
        log.info(-100000000000, value: TestStruct())
        log.info(NSNull(), value: [[[2]]])
        
        log.error(Void(), value: Void())
        log.error(1.0, value: 1.0)
    }
    
    func testSimpleLoggingWithoutValue() {
        let log = LogFlume.self
        log.formatType = .complete
        log.dateFormat = "HH:mm"
        let xcode = XcodeLoggingChannel()
        XCTAssertTrue(log.addChannels(xcode))
        
        
        // default simple logging
        log.verbose("SHLEE is Pulple")
        log.verbose(123)
        
        log.info(-100000000000)
        log.info(NSNull())
        
        log.error(Void())
        log.error(1.0)
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
