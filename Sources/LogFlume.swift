//
//  LogFlume.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/24.
//

import Foundation

open class LogFlume {

    public static let version = "1.0.0"
    
    private static let dateFormatter = DateFormatter()
    private static var dateFormat: String = "yyyy-MM-dd HH:mm:ss.SSS"
    
    /// channels queue
    private static let queue = DispatchQueue(label: "channels queue", attributes: .concurrent)
    
    public private(set) static var channels = LoggingChannelSet()
    
    // what we need(?)
    // 1. queue 동시성 제어 (actor)
    // 2. channels 보낼 채널들 관리
    // 3. DateFormatter 언제 로그 날렸는지 확인
    // 4.
    
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
    
    public static func performLogging(
        _ level: LogFlume.Level,
        fileName: String,
        line: UInt,
        funcName: String,
        threadName: String,
        message: @autoclosure () -> Any,
        printerType: LogFlume.PrinterType
    ) {
        var logMessage: String = "\(message())"
        
        channels.iterate { channel in
            let channelQueue = channel.queue
            
            channelQueue.async {
                let _ = channel.performLogging(level, fileName: fileName, line: line, funcName: funcName, message: logMessage, printerType: printerType)
            }
            
        }
    }
}



extension LogFlume {
    public enum PrinterType {
        /// use `print()`
        case `default`
        
        /// use `debugPrint()`
        case debug
        
        /// use `dump()`
//      ▿ 2 elements
//        ▿ Person
//          - name: "Alice"
//          - age: 28
//        ▿ Person
//          - name: "Bob"
//          - age: 35
        case dump
    }
}


extension LogFlume {
    public enum FormatType {
        /// [Level] ▷ Any...
        case short
        
        /// [Level] file:line funcName ▷ Any...
        case medium
        
        /// Time: [Level] file:line funcName ▷ Any...
        case long
        
        /// Time: [Level] file:line funcName [Thread Name] ▷ Any...
        case full
    }
}

extension LogFlume {
    public enum Level: String {
        case verbose = "📢 [VERBOSE]"
        case debug = "🛠 [DEBUG]"
        case info = "💡 [INFO]"
        case warning = "⚠️ [WARNING]"
        case error = "🚨 [ERROR]"
        
        fileprivate func intValue() -> Int {
            let _intValue: [Level: Int] = [
                .verbose: 0,
                .debug: 1,
                .info: 2,
                .warning: 3,
                .error: 4
            ]
            
            return _intValue[self] ?? 4
        }
    }

}
