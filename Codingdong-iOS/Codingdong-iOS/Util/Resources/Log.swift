//
//  Log.swift
//  Codingdong-iOS
//
//  Created by Joy on 10/23/23.
//

import Foundation

public let log = Log()

public class Log {
    enum Level {
        case verbose
        case debug
        case info
        case warning
        case error

        var prefix: String {
            switch self {
            case .verbose: return "💬 VERBOSE"
            case .debug: return "🐛 DEBUG"
            case .info: return "ℹ️ INFO"
            case .warning: return "🔥 WARNING"
            case .error: return "🛠️ ERROR"
            }
        }
    }

    public func verbose(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        log(level: .verbose, file: file, function: function, line: line, message: message)
    }

    public func debug(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        log(level: .debug, file: file, function: function, line: line, message: message)
    }

    public func info(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        log(level: .info, file: file, function: function, line: line, message: message)
    }

    public func warning(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        log(level: .warning, file: file, function: function, line: line, message: message)
    }

    public func error(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let message = self.message(from: items)
        log(level: .error, file: file, function: function, line: line, message: message)
    }

    private func message(from items: [Any]) -> String {
        return items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }

    private func log(
        timestamp: Date = Date(),
        level: Level,
        file: StaticString,
        function: StaticString,
        line: UInt,
        message: String
    ) {
        #if DEBUG
        let timestamp = timestamp.description
        print("\(timestamp) \(level.prefix) \(file) - \(function) at line \(line) - \(message)")
        #endif
    }
}
