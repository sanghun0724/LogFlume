//
//  XcodeChannel.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/24.
//

import Foundation

public struct XcodeLoggingChannel: LoggingChannel {
    public var queue: DispatchQueue = DispatchQueue(label: "xcode.queue", attributes: .concurrent)
    
    func send(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        message: String,
        printerType: LogFlume.PrinterType,
        output: Any
    ) -> String? {
        let logString = performLogging(level,
                                       fileName: fileName,
                                       line: line,
                                       funcName: funcName,
                                       message: message,
                                       printerType: printerType,
                                       output: output)
        
        
        
        return logString
    }
}



