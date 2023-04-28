//
//  LoggingChannel.swift
//  LoggerTest
//
//  Created by sangheon on 2023/04/23.
//

import Foundation

public protocol LoggingChannel: Hashable {
    /// channnel's concurrency queue
    var queue: DispatchQueue { get }
    
    func performLogging(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        threadName: String,
        message: @autoclosure () -> Any,
        printerType: LogFlume.PrinterType
    ) -> String?
    
}


extension LoggingChannel {
    public func performLogging(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        message: @autoclosure () -> Any,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String? {
        
        
        
        return nil
    }
    
    private func name(_ value: Any) -> String {
        return "\(type(of: value))"
    }
    
    private func printLog(_ log: String,_ printerType: LogFlume.PrinterType, target: Any) {
        switch printerType {
        case .debug:
            Swift.print("\(log)")
            Swift.debugPrint(target)
        case .dump:
            Swift.print("\(log)")
            Swift.dump(target, name: name(target), indent: 2)
        case .default:
            Swift.print("\(log)")
            Swift.print(target)
        }
    }
}


