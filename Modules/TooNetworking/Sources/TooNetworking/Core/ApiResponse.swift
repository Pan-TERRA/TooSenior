import Foundation

public struct ApiResponse<T: Sendable>: Sendable {
    public let value: T
    public let httpResponse: HTTPURLResponse
    public let request: URLRequest
    
    public init(value: T, httpResponse: HTTPURLResponse, request: URLRequest) {
        self.value = value
        self.httpResponse = httpResponse
        self.request = request
    }
    
    public var statusCode: Int {
        return httpResponse.statusCode
    }
    
    public func isUnauthorized() -> Bool {
        return statusCode == 401
    }
    
    public func networkError() -> NetworkError? {
        switch statusCode {
        case 401:
            return .unauthorized
        case 400...499:
            return .httpError(statusCode: statusCode)
        case 500...599:
            return .serverError(statusCode, nil)
        default:
            return nil
        }
    }
}