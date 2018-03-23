//
//  DSLogger.swift
//  DeepStreamDemo
//
//  Created by Satish on 23/03/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

/// Represents a class will log client events.
public protocol Logger: class {
    
    // MARK: Properties
    
    /// Whether to log or not
    var log: Bool { get set }
    
    /// Whether user NSLog or not
    var useNSLog: Bool { get set }
    
    // MARK: Methods
    
    func verbose(_ message: @autoclosure () -> String, type: String)
    func warn(_ message: @autoclosure () -> String, type: String)
    func info(_ message: @autoclosure () -> String, type: String)
    func debug(_ message: @autoclosure () -> String, type: String)
    func log(_ message: @autoclosure () -> String, type: String)
    func error(_ message: @autoclosure () -> String, type: String)
}

public extension Logger {
    
    /// log something generally unimportant (lowest priority)
    func verbose(_ message: @autoclosure () -> String, type: String) {
        abstractLog("VERBOSE", message: message, type: type)
    }
    
    /// log something which help during debugging (low priority)
    func debug(_ message: @autoclosure () -> String, type: String) {
        abstractLog("DEBUG", message: message, type: type)
    }
    
    /// log something which you are really interested but which is not an issue or error (normal priority)
    func info(_ message: @autoclosure () -> String, type: String) {
        abstractLog("INFO", message: message, type: type)
    }
    
    /// log something which may cause big trouble soon (high priority)
    func warn(_ message: @autoclosure () -> String, type: String) {
        abstractLog("WARNING", message: message, type: type)
    }
    
    /// log something which will keep you awake at night (highest priority)
    func error(_ message: @autoclosure () -> String, type: String) {
        abstractLog("ERROR", message: message, type: type)
    }
    
    func log(_ message: @autoclosure () -> String, type: String) {
        abstractLog("LOG", message: message, type: type)
    }
    
    private func abstractLog(_ logType: String, message: @autoclosure () -> String, type: String) {
        guard log else { return }
        if useNSLog {
            #if os(Linux)
                print("\(logType) \(type): %@", message())
            #else
                NSLog("\(logType) \(type): %@", message())
            #endif
        } else {
            print("\(logType) \(type): %@", message())
        }
    }
}

class DefaultLogger: Logger {
    static var logger: Logger = DefaultLogger()
    var log = false
    var useNSLog = false
}
