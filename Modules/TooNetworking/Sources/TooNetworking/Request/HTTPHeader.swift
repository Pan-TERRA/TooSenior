import Foundation

public struct HTTPHeader: Sendable {
    public let name: String
    public let value: String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public extension HTTPHeader {
    static let authorization = "Authorization"
    static let contentType = "Content-Type"
    static let accept = "Accept"
    static let userAgent = "User-Agent"
}
