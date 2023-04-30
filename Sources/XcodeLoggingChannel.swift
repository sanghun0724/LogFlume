//
//  XcodeChannel.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/24.
//

import Foundation

public struct XcodeLoggingChannel: LoggingChannel {
    
    public var queue: DispatchQueue = DispatchQueue(label: "xcode.serieal.queue")
    
    public func sendLog(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        message: String,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String? {
        let logString = performLogging(level,
                                       fileName: fileName,
                                       line: line,
                                       funcName: funcName,
                                       message: message,
                                       printerType: printerType,
                                       targetValue: targetValue)
        
        return logString
    }
}



