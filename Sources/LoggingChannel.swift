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
    
    func sendLog(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        threadName: String,
        message: String,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String?
    
    func performLogging(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        threadName: String,
        message: String,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String?
    
}


extension LoggingChannel {
    public func performLogging(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        threadName:String,
        message: String,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String? {
        
        printLog(message, .debug, target: [1])
        
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
    
//    private func logString(_ level: Log.Level, fileName: String, line: UInt, funcName: String) -> String {
//        let file = fileName.components(separatedBy: "/").last ?? ""
//        switch formatType {
//        case .short:
//            return "\(level.string)"
//        case .medium:
//            return "\(level.string) \(funcName)"
//        case .long:
//            return "\(time): \(level.string) \(file):\(line) \(funcName)"
//        case .full:
//            let thread = threadName
//            return "\(time): \(level.string) \(file):\(line) \(funcName) [\(thread)]"
//        }
//    }
}


