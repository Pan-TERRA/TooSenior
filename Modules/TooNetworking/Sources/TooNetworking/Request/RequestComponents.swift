import Foundation

// MARK: - Path Component

public struct Path: RequestComponent {
    private let path: String
    
    public init(_ path: String) {
        self.path = path
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setPath(path)
    }
}

// MARK: - Method Component

public struct Method: RequestComponent {
    private let method: HTTPMethod
    
    public init(_ method: HTTPMethod) {
        self.method = method
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setMethod(method)
    }
}

// MARK: - Parameters Components

public struct Parameters: RequestComponent {
    private let parameters: HTTPParameters
    
    public init(_ parameters: HTTPParameters) {
        self.parameters = parameters
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setParameters(parameters)
    }
}

public struct JSONBody<T: Encodable & Sendable>: RequestComponent {
    private let body: T
    private let encoder: JSONEncoder
    
    public init(_ body: T, encoder: JSONEncoder = JSONEncoder()) {
        self.body = body
        self.encoder = encoder
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        do {
            let data = try encoder.encode(body)
            builder.setParameters(.body(data, .json))
        } catch {
            // In a real implementation, you might want to handle this differently
            // For now, we'll fall back to empty parameters
            builder.setParameters(.empty)
        }
    }
}

public struct QueryParameters: RequestComponent {
    private let parameters: [String: String]
    
    public init(_ parameters: [String: String]) {
        self.parameters = parameters
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setParameters(.query(parameters))
    }
}

public struct MultipartBody: RequestComponent {
    private let parameters: MultipartParameters
    
    public init(_ parameters: MultipartParameters) {
        self.parameters = parameters
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setParameters(.multipart(parameters: parameters))
    }
}

// MARK: - Header Components

public struct Header: RequestComponent {
    private let header: HTTPHeader
    
    public init(_ header: HTTPHeader) {
        self.header = header
    }
    
    public init(name: String, value: String) {
        self.header = HTTPHeader(name: name, value: value)
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.addHeader(header)
    }
}

public struct ContentType: RequestComponent {
    private let contentType: String
    
    public init(_ contentType: String) {
        self.contentType = contentType
    }
    
    public static var json: ContentType {
        ContentType("application/json")
    }
    
    public static var xml: ContentType {
        ContentType("application/xml")
    }
    
    public static var formURLEncoded: ContentType {
        ContentType("application/x-www-form-urlencoded")
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.addHeader(HTTPHeader(name: "Content-Type", value: contentType))
    }
}

public struct Accept: RequestComponent {
    private let acceptType: String
    
    public init(_ acceptType: String) {
        self.acceptType = acceptType
    }
    
    public static var json: Accept {
        Accept("application/json")
    }
    
    public static var xml: Accept {
        Accept("application/xml")
    }
    
    public static var any: Accept {
        Accept("*/*")
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.addHeader(HTTPHeader(name: "Accept", value: acceptType))
    }
}

// MARK: - Timeout Component

public struct Timeout: RequestComponent {
    private let timeout: TimeInterval
    
    public init(_ timeout: TimeInterval) {
        self.timeout = timeout
    }
    
    public static func seconds(_ seconds: Int) -> Timeout {
        Timeout(TimeInterval(seconds))
    }
    
    public static func minutes(_ minutes: Int) -> Timeout {
        Timeout(TimeInterval(minutes * 60))
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setTimeout(timeout)
    }
}

// MARK: - Cache Policy Component

public struct CachePolicy: RequestComponent {
    private let policy: URLRequest.CachePolicy
    
    public init(_ policy: URLRequest.CachePolicy) {
        self.policy = policy
    }
    
    public static var useProtocolCachePolicy: CachePolicy {
        CachePolicy(.useProtocolCachePolicy)
    }
    
    public static var reloadIgnoringLocalCacheData: CachePolicy {
        CachePolicy(.reloadIgnoringLocalCacheData)
    }
    
    public static var returnCacheDataElseLoad: CachePolicy {
        CachePolicy(.returnCacheDataElseLoad)
    }
    
    public static var returnCacheDataDontLoad: CachePolicy {
        CachePolicy(.returnCacheDataDontLoad)
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setCachePolicy(policy)
    }
}

// MARK: - Authorization Component

public struct Auth: RequestComponent {
    private let authorization: Authorization?
    
    public init(_ authorization: Authorization?) {
        self.authorization = authorization
    }
    
    public static var currentUser: Auth {
        Auth(.currentUser)
    }
    
    public static var none: Auth {
        Auth(nil)
    }
    
    public func apply(to builder: inout HTTPRequestBuilder) {
        builder.setAuthorization(authorization)
    }
}