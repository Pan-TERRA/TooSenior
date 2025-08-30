import Foundation

public protocol NetworkPlugin: Sendable {
    func processRequest(_ request: inout URLRequest) async throws
    func processResponse(_ response: HTTPURLResponse, data: Data, originalRequest: URLRequest) async throws
    func processError(_ error: Error, request: URLRequest) async -> Error
}