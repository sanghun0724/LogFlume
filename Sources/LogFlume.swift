//
//  LogFlume.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/24.
//

import Foundation

open class LogFlume {

    public static let version = "1.0.0"
    public static let formatType: LogFlume.FormatType = .complete
    
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
    
    public static func verbose() {
        
    }
    
    public static func excuteLogging(
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
            
            channelQueue.async {
                let _ = channel.sendLog(level, fileName: fileName, line: line, funcName: funcName, message: logMessage, printerType: printerType, targetValue: targetValue)
            }
        }
    }
    
}
