//
//  XcodeChannel.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/24.
//

import Foundation

public struct XcodeLoggingChannel: LoggingChannel {
    
    
    public var queue: DispatchQueue = DispatchQueue(label: "xcode.queue", attributes: .concurrent)
    
    public func sendLog(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        threadName: String,
        message: String,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String? {
        let logString = performLogging(level,
                                       fileName: fileName,
                                       line: line,
                                       funcName: funcName,
                                       threadName: threadName,
                                       message: message,
                                       printerType: printerType,
                                       targetValue: targetValue)
        
        
        
        return logString
    }
}



