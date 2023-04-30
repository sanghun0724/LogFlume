//
//  Extensions.swift
//  LogFlume
//
//  Created by sangheon on 2023/04/30.
//

import Foundation

extension Thread {
    var threadName: String {
        if isMainThread {
            return "main"
        } else if let threadName = Thread.current.name, !threadName.isEmpty {
            return threadName
        } else {
            return description
        }
    }
}
