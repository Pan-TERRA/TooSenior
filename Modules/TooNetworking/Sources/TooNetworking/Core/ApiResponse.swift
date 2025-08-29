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
}