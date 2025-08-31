import Foundation

public protocol TokenRefreshInteractorProtocol: Sendable {
    func shouldRefreshToken(for response: HTTPURLResponse) async -> Bool
    func isTokenExpired() async -> Bool
    func refreshToken() async throws -> String
    func getCurrentToken() async -> String?
    func clearTokens() async
}