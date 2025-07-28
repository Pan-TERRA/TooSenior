import Foundation

struct SignInRequest: Codable, Equatable {
    let email: String
    let password: String
}

struct SignUpRequest: Codable, Equatable {
    let email: String
    let password: String
    let username: String
}

struct RefreshTokenRequest: Codable, Equatable {
    let refreshToken: String
}