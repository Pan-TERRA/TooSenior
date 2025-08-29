import Foundation

public struct HTTPRequest: Sendable {
    public let path: String
    public let method: HTTPMethod
    public let parameters: HTTPParameters
    public let headers: [HTTPHeader]
    public let timeout: TimeInterval
    public let cachePolicy: URLRequest.CachePolicy
    
    public init(
        path: String,
        method: HTTPMethod = .get,
        parameters: HTTPParameters = .empty,
        headers: [HTTPHeader] = [],
        timeout: TimeInterval = 30,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.timeout = timeout
        self.cachePolicy = cachePolicy
    }
}