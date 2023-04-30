//
//  LoggingChannelTests.swift
//  LogFlumeTests
//
//  Created by sangheon on 2023/04/29.
//

import XCTest
@testable import LogFlume

final class LoggingChannelTests: XCTestCase {

    override func setUpWithError() throws {
       try super.setUpWithError()
    }

    override func tearDownWithError() throws {
       try super.tearDownWithError()
    }

    func testExample() throws {
        let mockLoggingChannel = MockLoggingChannel()
        
        mockLoggingChannel.performLogging(.info, fileName: "fileName", line: 18, funcName: "funcName", message: "message", printerType: .debug, targetValue: [2,23,13314,1331,134])
        // Thread Name -> main -> back 이렇게 나오게끔 ㄱ
    }
     
}

final class MockLoggingChannel: LoggingChannel {
    static func == (lhs: MockLoggingChannel, rhs: MockLoggingChannel) -> Bool {
            return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    var queue: DispatchQueue = .global()
    
    func sendLog(_ level: LogFlume.Level, fileName: String, line: UInt, funcName: String, message: String, printerType: LogFlume.PrinterType, targetValue: Any) -> String? {
        
        return ""
    }
    
}
