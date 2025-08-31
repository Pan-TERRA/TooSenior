import Foundation

// MARK: - Request Component Protocol

public protocol RequestComponent: Sendable {
    func apply(to builder: inout HTTPRequestBuilder)
}

// MARK: - Result Builder

@resultBuilder
public struct RequestBuilder {
    public static func buildBlock(_ components: RequestComponent...) -> [RequestComponent] {
        components
    }
    
    public static func buildOptional(_ component: [RequestComponent]?) -> [RequestComponent] {
        component ?? []
    }
    
    public static func buildEither(first component: [RequestComponent]) -> [RequestComponent] {
        component
    }
    
    public static func buildEither(second component: [RequestComponent]) -> [RequestComponent] {
        component
    }
    
    public static func buildArray(_ components: [[RequestComponent]]) -> [RequestComponent] {
        components.flatMap { $0 }
    }
}

// MARK: - HTTPRequest Builder

public struct HTTPRequestBuilder: Sendable {
    private(set) var path: String = ""
    private(set) var method: HTTPMethod = .get
    private(set) var parameters: HTTPParameters = .empty
    private(set) var headers: [HTTPHeader] = []
    private(set) var timeout: TimeInterval = 30
    private(set) var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    private(set) var authorization: Authorization = .none
    
    public init() {}
    
    public mutating func setPath(_ path: String) {
        self.path = path
    }
    
    public mutating func setMethod(_ method: HTTPMethod) {
        self.method = method
    }
    
    public mutating func setParameters(_ parameters: HTTPParameters) {
        self.parameters = parameters
    }
    
    public mutating func addHeader(_ header: HTTPHeader) {
        self.headers.append(header)
    }
    
    public mutating func setTimeout(_ timeout: TimeInterval) {
        self.timeout = timeout
    }
    
    public mutating func setCachePolicy(_ cachePolicy: URLRequest.CachePolicy) {
        self.cachePolicy = cachePolicy
    }
    
    public mutating func setAuthorization(_ authorization: Authorization) {
        self.authorization = authorization
    }
    
    public func build() -> HTTPRequest {
        HTTPRequest(
            path: path,
            method: method,
            parameters: parameters,
            headers: headers,
            timeout: timeout,
            cachePolicy: cachePolicy,
            authorization: authorization
        )
    }
}
