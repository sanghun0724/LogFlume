//
//  LogFlume.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/24.
//

import Foundation

open class LogFlume {
    
    public static let version = "0.1.0"
    public static var formatType: LogFlume.FormatType = .complete // default
    
    internal static let dateFormatter = DateFormatter()
    public static var dateFormat: String = "yyyy-MM-dd HH:mm:ss.SSS"
    
    /// channels queue
    private static let queue = DispatchQueue(label: "channels queue", attributes: .concurrent)
    
    public private(set) static var channels = LoggingChannelSet()
    
    // MARK: set operations
    
    /// Returns the success or failure of a function in Bool.
    @discardableResult
    public static func addChannels(_ channel: any LoggingChannel) -> Bool {
        if channels.contain(channel) {
            return false
        }
        channels.insert(channel)
        return true
    }
    
    /// Returns the success or failure of a function in Bool.
    public static func removeChannels(_ channel: any LoggingChannel) -> Bool {
        if !channels.contain(channel) {
            return false
        }
        channels.removeChannel(channel)
        return true
    }
    
    /// Returns the success or failure of a function in Bool.
    public static func removeAllChannels() -> Bool {
        if channels.countChannels() == 0 {
            return false
        }
        channels.removeAll()
        return true
    }
    
    public static func countChannels() -> Int {
        channels.countChannels()
    }
    
    // MARK: Logging
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func verbose(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default,
        value: Any...
    ) {
#if swift(>=5)
        executeLoggingWithTargetValue(.verbose,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message(),
                                      printerType: printerType,
                                      targetValue: value)
#else
        executeLoggingWithTargetValue(.verbose,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message,
                                      printerType: printerType,
                                      targetValue: value)
#endif
    }
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func verbose(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default
    ) {
#if swift(>=5)
        executeLoggingWithoutTargetValue(.verbose,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#else
        executeLoggingWithoutTargetValue(.verbose,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#endif
    }
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func debug(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default,
        value: Any...
    ) {
#if swift(>=5)
        executeLoggingWithTargetValue(.debug,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message(),
                                      printerType: printerType,
                                      targetValue: value)
#else
        executeLoggingWithTargetValue(.debug,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message,
                                      printerType: printerType,
                                      targetValue: value)
#endif
    }
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func debug(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default
    ) {
#if swift(>=5)
        executeLoggingWithoutTargetValue(.debug,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#else
        executeLoggingWithoutTargetValue(.debug,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#endif
    }
    
    /// Log Information that is useful for tracking the application's general flow, such as which requests were received and which modules were loaded.
    public static func info(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default,
        value: Any...
    ) {
#if swift(>=5)
        executeLoggingWithTargetValue(.info,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message(),
                                      printerType: printerType,
                                      targetValue: value)
#else
        executeLoggingWithTargetValue(.info,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message,
                                      printerType: printerType,
                                      targetValue: value)
#endif
    }
    
    /// Log Information that is useful for tracking the application's general flow, such as which requests were received and which modules were loaded.
    public static func info(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default
    ) {
#if swift(>=5)
        executeLoggingWithoutTargetValue(.info,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#else
        executeLoggingWithoutTargetValue(.info,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#endif
    }
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func warning(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default,
        value: Any...
    ) {
#if swift(>=5)
        executeLoggingWithTargetValue(.warning,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message(),
                                      printerType: printerType,
                                      targetValue: value)
#else
        executeLoggingWithTargetValue(.warning,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message,
                                      printerType: printerType,
                                      targetValue: value)
#endif
    }
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func warning(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default
    ) {
#if swift(>=5)
        executeLoggingWithoutTargetValue(.warning,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#else
        executeLoggingWithoutTargetValue(.warning,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#endif
    }
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func error(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default,
        value: Any...
    ) {
#if swift(>=5)
        executeLoggingWithTargetValue(.error,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message(),
                                      printerType: printerType,
                                      targetValue: value)
#else
        executeLoggingWithTargetValue(.error,
                                      fileName: file,
                                      line: line,
                                      funcName: function,
                                      message: message,
                                      printerType: printerType,
                                      targetValue: value)
#endif
    }
    
    /// Log Detailed information about the application's internal state, useful for debugging and development purposes.
    public static func error(
        _ message: @autoclosure () -> Any,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        printerType: PrinterType = .default
    ) {
#if swift(>=5)
        executeLoggingWithoutTargetValue(.error,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#else
        executeLoggingWithoutTargetValue(.error,
                                         fileName: file,
                                         line: line,
                                         funcName: function,
                                         message: message(),
                                         printerType: printerType)
#endif
    }
    
    public static func executeLoggingWithTargetValue(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        message: @autoclosure () -> Any,
        printerType: LogFlume.PrinterType,
        targetValue: Any...
    ) {
        let logMessage: String = "\(message())"
        
        channels.iterate { channel in
            let channelQueue = channel.queue
            
            channelQueue.sync {
                let _ = channel.sendLog(level, fileName: fileName, line: line, funcName: funcName, message: logMessage, printerType: printerType, targetValue: targetValue)
            }
        }
    }
    
    public static func executeLoggingWithoutTargetValue(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        message: @autoclosure () -> Any,
        printerType: LogFlume.PrinterType
    ) {
        let logMessage: String = "\(message())"
        
        channels.iterate { channel in
            let channelQueue = channel.queue
            
            channelQueue.async {
                let _ = channel.sendLog(level, fileName: fileName, line: line, funcName: funcName, message: logMessage, printerType: printerType, targetValue: Void())
            }
        }
    }
    
}
