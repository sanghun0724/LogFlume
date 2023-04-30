//
//  LogType.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/29.
//

import Foundation

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

extension LogFlume {
    public enum DateFormatType {
        case simple
    }
}


extension LogFlume {
    public enum FormatType {
        
        /// [Level] file:line funcName ▷ Any...
        case simple
        
        /// Time: [Level] file:line funcName ▷ Any...
        case detail
        
        /// Time: [Level] file:line funcName [Thread Name] ▷ Any...
        case complete
    }
}

