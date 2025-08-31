import Foundation

public struct HTTPRequest: Sendable {
    public let path: String
    public let method: HTTPMethod
    public let parameters: HTTPParameters
    public let headers: [HTTPHeader]
    public let timeout: TimeInterval
    public let cachePolicy: URLRequest.CachePolicy
    public let authorization: Authorization?
    
    private init(
        path: String,
        method: HTTPMethod,
        parameters: HTTPParameters,
        headers: [HTTPHeader],
        timeout: TimeInterval,
        cachePolicy: URLRequest.CachePolicy,
        authorization: Authorization?
    ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.timeout = timeout
        self.cachePolicy = cachePolicy
        self.authorization = authorization
    }
    
    public static func authorized(
        path: String,
        method: HTTPMethod,
        parameters: HTTPParameters = .empty,
        headers: [HTTPHeader] = [],
        timeout: TimeInterval = 30,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) -> HTTPRequest {
        HTTPRequest(
            path: path,
            method: method,
            parameters: parameters,
            headers: headers,
            timeout: timeout,
            cachePolicy: cachePolicy,
            authorization: .currentUser
        )
    }
    
    public static func unauthorized(
        path: String,
        method: HTTPMethod,
        parameters: HTTPParameters = .empty,
        headers: [HTTPHeader] = [],
        timeout: TimeInterval = 30,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) -> HTTPRequest {
        HTTPRequest(
            path: path,
            method: method,
            parameters: parameters,
            headers: headers,
            timeout: timeout,
            cachePolicy: cachePolicy,
            authorization: nil
        )
    }
    
    func urlRequest(baseURL: String, defaultHeaders: [String: String]) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidURL(baseURL + path)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        
        for (key, value) in defaultHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.name)
        }
        
        if let authHeader = authorization?.headerValue {
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}