import Foundation

struct AuthTokens: Codable, Equatable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresAt: Date
    let refreshExpiresAt: Date
    
    init(
        accessToken: String,
        refreshToken: String,
        tokenType: String,
        expiresAt: Date,
        refreshExpiresAt: Date
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.tokenType = tokenType
        self.expiresAt = expiresAt
        self.refreshExpiresAt = refreshExpiresAt
    }
}