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
        message: String,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String?
    
    func performLogging(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
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
        message: String,
        printerType: LogFlume.PrinterType,
        targetValue: Any
    ) -> String? {
        let defaultLogString = defaultLogString(level,
                                                message: message,
                                                fileName: fileName,
                                                line: line,
                                                funcName: funcName)
        guard let items = targetValue as? [Any] else {
            return printSingleItemLog(defaultLogString, printerType, item: targetValue)
        }
        
        switch items.count {
        case 0:
            Swift.print(defaultLogString)
            return defaultLogString
        case 1:
            return printSingleItemLog(defaultLogString, printerType, item: items[0])
        default:
            return printMultipleItemLog(defaultLogString, printerType, items: items)
        }
    }
    
    private func name(_ value: Any) -> String {
        return "\(type(of: value))"
    }
    
    private func printSingleItemLog(
        _ logString: String,
        _ printerType: LogFlume.PrinterType,
        item: Any) -> String {
            switch printerType {
            case .debug:
                Swift.print("\(logString) ▽")
                Swift.debugPrint(item)
            case .dump:
                var dumpedString = String()
                Swift.dump(item, to: &dumpedString, name: name(item), indent: 2)
                Swift.print(NSString(string: "\(logString) \n▽\(dumpedString)"))
            case .default:
                Swift.print("\(logString) ▽")
                Swift.print(item)
            }
            
            return logString + "\(item)"
        }
    
    private func printMultipleItemLog(
        _ logString: String,
        _ printType: LogFlume.PrinterType,
        items: [Any]
    ) -> String {
        switch printType {
        case .debug:
            Swift.print("\(logString) ▽")
            for item in items {
                Swift.debugPrint(item)
            }
            
        case .dump:
            Swift.print("\(logString) ▽")
            for item in items {
                Swift.dump(item, name: name(item), indent: 2)
            }
            
        case .default:
            Swift.print("\(logString) ▽")
            for item in items {
                Swift.print(item)
            }
        }
        
        return logString + "\(items)"
    }
    
    
    private func defaultLogString(_ level: LogFlume.Level, message: String, fileName: String, line: UInt, funcName: String) -> String {
        let file = fileName.components(separatedBy: "/").last ?? ""
        switch LogFlume.formatType {
        case .simple:
            return "\(level.rawValue) \(funcName) \(message)"
        case .detail:
            return "\(time): \(level.rawValue) \(file):\(line) \(funcName) \(message)"
        case .complete:
            let thread = Thread.current.threadName
            return "\(time): \(level.rawValue) \(file):\(line) \(funcName) [\(thread)] \(message)"
        }
    }
    
    /// currnet time when log
    private var time: String {
        let now = Date()
        LogFlume.dateFormatter.dateFormat = LogFlume.dateFormat
        let dateNow = LogFlume.dateFormatter.string(from: now)
        
        return dateNow
    }
}
