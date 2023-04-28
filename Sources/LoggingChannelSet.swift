//
//  LoggingChannelSet.swift
//  LoggerTest
//
//  Created by sangheon on 2023/04/23.
//

import Foundation

public class LoggingChannelSet {
    private var queue = DispatchQueue(label: "set.queue", attributes: .concurrent)
    private var _set = Set<AnyHashable>()
    
    var set:  Set<AnyHashable> {
        get {
            return queue.sync {
                return _set
            }
        } set {
            queue.async(flags: .barrier) {
                self._set = newValue
            }
        }
    }
    
    func insert<T>(_ channel: T) where T: LoggingChannel, T: Hashable {
        set.insert(AnyHashable(channel))
    }
    
    func iterate(doing: (any LoggingChannel) -> Void ) {
        for item in set {
            guard let item = item as? (any LoggingChannel) else {
                return
            }
            doing(item)
        }
    }
    
    /// check if it is contain channel
    func contain<T>(_ channel: T) -> Bool where T: LoggingChannel, T: Hashable {
        set.contains(AnyHashable(channel))
    }
    
    /// count all channels
    func countChannels() -> Int {
        set.count 
    }
    
    /// remove first set element
    func removeChannel(_ channel: any LoggingChannel) {
        set.remove(channel)
    }
    
    /// remove all your channel
    func removeAll() {
        set.removeAll()
    }
}

