import Foundation

public protocol TokenRefreshInteractorProtocol: Sendable {
    func validateAndRefreshToken() async throws
    func attemptTokenRefresh() async -> Bool
    func getCurrentToken() async -> String?
    func isTokenExpired() async -> Bool
    func clearTokens() async
}