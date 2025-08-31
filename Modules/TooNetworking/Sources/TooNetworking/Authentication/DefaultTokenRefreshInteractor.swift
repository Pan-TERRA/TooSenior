import Foundation

public final class DefaultTokenRefreshInteractor: TokenRefreshInteractorProtocol {
    private let tokenStore: SecureTokenStoreProtocol
    
    public init(tokenStore: SecureTokenStoreProtocol = SecureTokenStore.shared) {
        self.tokenStore = tokenStore
    }
    
    public func validateAndRefreshToken() async throws {
        if await isTokenExpired() {
            _ = await attemptTokenRefresh()
            if await isTokenExpired() {
                throw NetworkError.tokenRefreshFailed
            }
        }
    }
    
    public func attemptTokenRefresh() async -> Bool {
        guard let currentToken = await getCurrentToken() else {
            return false
        }
        
        do {
            let newToken = try await performTokenRefresh(currentToken: currentToken)
            await tokenStore.setToken(newToken)
            return true
        } catch {
            return false
        }
    }
    
    public func getCurrentToken() async -> String? {
        return await tokenStore.getToken()
    }
    
    public func isTokenExpired() async -> Bool {
        guard let token = await getCurrentToken() else {
            return true
        }
        
        return isJWTExpired(token)
    }
    
    public func clearTokens() async {
        await tokenStore.clearToken()
    }
    
    private func performTokenRefresh(currentToken: String) async throws -> String {
        // TODO: This should call your actual token refresh endpoint
        // Mock implementation for testing - replace with real API call
        try await Task.sleep(for: .milliseconds(300))
        
        // Return a mock JWT token with future expiration (1 hour from now)
        let futureTimestamp = Date().timeIntervalSince1970 + 3600 // 1 hour
        let mockPayload = "{\"sub\":\"mock-user\",\"exp\":\(Int(futureTimestamp))}"
        let mockPayloadBase64 = Data(mockPayload.utf8).base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
        
        return "mock.header.\(mockPayloadBase64).mock.signature"
    }
    
    private func isJWTExpired(_ token: String) -> Bool {
        let parts = token.components(separatedBy: ".")
        guard parts.count == 3,
              let payloadData = Data(base64URLEncoded: parts[1]),
              let payload = try? JSONSerialization.jsonObject(with: payloadData) as? [String: Any],
              let exp = payload["exp"] as? TimeInterval else {
            return true
        }
        
        let expirationDate = Date(timeIntervalSince1970: exp)
        let bufferTime: TimeInterval = 60
        return Date().addingTimeInterval(bufferTime) >= expirationDate
    }
}

private extension Data {
    init?(base64URLEncoded string: String) {
        let base64 = string
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let paddedBase64 = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
        self.init(base64Encoded: paddedBase64)
    }
}