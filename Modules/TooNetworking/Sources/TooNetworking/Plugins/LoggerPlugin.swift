import Foundation

public struct LoggerPlugin: NetworkPlugin {
    private let logger: Logger
    
    public init(logger: Logger = ConsoleLogger()) {
        self.logger = logger
    }
    
    public func processRequest(_ request: inout URLRequest) async throws {
        logger.info("🚀 \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "unknown")")
        if let body = request.httpBody {
            logger.debug("📤 Body: \(String(data: body, encoding: .utf8) ?? "binary")")
        }
    }
    
    public func processResponse(_ response: HTTPURLResponse, data: Data, originalRequest: URLRequest) async throws {
        let status = response.statusCode
        let emoji = status < 400 ? "✅" : "❌"
        logger.info("\(emoji) \(status) \(originalRequest.url?.absoluteString ?? "unknown")")
        logger.debug("📥 Response: \(String(data: data, encoding: .utf8) ?? "binary")")
    }
    
    public func processError(_ error: Error, request: URLRequest) async -> Error {
        logger.error("💥 Error: \(error) for \(request.url?.absoluteString ?? "unknown")")
        return error
    }
}