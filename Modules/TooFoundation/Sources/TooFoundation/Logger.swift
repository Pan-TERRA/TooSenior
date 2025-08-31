import Foundation

public protocol Logger: Sendable {
    func info(_ message: String)
    func debug(_ message: String)
    func error(_ message: String)
}

public struct ConsoleLogger: Logger {
    public init() {}
    
    public func info(_ message: String) {
        print("INFO: \(message)")
    }
    
    public func debug(_ message: String) {
        print("DEBUG: \(message)")
    }
    
    public func error(_ message: String) {
        print("ERROR: \(message)")
    }
}