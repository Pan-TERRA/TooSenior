import Foundation

public struct HTTPRequest: Sendable {
    public let path: String
    public let method: HTTPMethod
    public let parameters: HTTPParameters
    public let headers: [HTTPHeader]
    public let timeout: TimeInterval
    public let cachePolicy: URLRequest.CachePolicy
    public let authorization: Authorization
    
    init(
        path: String,
        method: HTTPMethod,
        parameters: HTTPParameters = .empty,
        headers: [HTTPHeader] = [],
        timeout: TimeInterval = 30,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        authorization: Authorization = .none
    ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.timeout = timeout
        self.cachePolicy = cachePolicy
        self.authorization = authorization
    }
    
    
    // MARK: - Declarative API
    
    public static func build(@RequestBuilder _ content: () -> [RequestComponent]) -> HTTPRequest {
        var builder = HTTPRequestBuilder()
        let components = content()
        
        for component in components {
            component.apply(to: &builder)
        }
        
        return builder.build()
    }
    
    func urlRequest(baseURL: String, defaultHeaders: [String: String]) throws -> URLRequest {
        var finalURL: URL
        
        switch parameters {
        case .query(let queryParams), .bodyAndQuery(_, _, let queryParams):
            guard var urlComponents = URLComponents(string: baseURL + path) else {
                throw NetworkError.invalidURL(baseURL + path)
            }
            
            let queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                throw NetworkError.invalidURL(baseURL + path)
            }
            finalURL = url
            
        case .multipleValueFieldQuery(let multiValueParams):
            guard var urlComponents = URLComponents(string: baseURL + path) else {
                throw NetworkError.invalidURL(baseURL + path)
            }
            
            var queryItems: [URLQueryItem] = []
            for (key, values) in multiValueParams {
                queryItems.append(contentsOf: values.map { URLQueryItem(name: key, value: $0) })
            }
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                throw NetworkError.invalidURL(baseURL + path)
            }
            finalURL = url
            
        default:
            guard let url = URL(string: baseURL + path) else {
                throw NetworkError.invalidURL(baseURL + path)
            }
            finalURL = url
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        
        for (key, value) in defaultHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.name)
        }
        
        switch parameters {
        case .body(let data, let contentType), .bodyAndQuery(let data, let contentType, _):
            request.httpBody = data
            request.setValue(contentType.toString(), forHTTPHeaderField: "Content-Type")
            
        case .query, .multipleValueFieldQuery, .empty:
            break
        }
        
        return request
    }
}
