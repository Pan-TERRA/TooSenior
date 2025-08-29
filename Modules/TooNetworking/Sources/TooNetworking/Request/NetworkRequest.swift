import Foundation

public struct NetworkRequest: Sendable {
    public let httpRequest: HTTPRequest
    public let authorization: Authorization?
    
    public init(httpRequest: HTTPRequest, authorization: Authorization? = .currentUser) {
        self.httpRequest = httpRequest
        self.authorization = authorization
    }
}