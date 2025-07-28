import Foundation

protocol AuthRepositoryProtocol {
    func signIn(email: String, password: String) async throws -> AuthTokens
    func signUp(email: String, password: String, username: String) async throws -> AuthTokens
    func refreshToken() async throws -> AuthTokens
    func logout() async throws
}

final class AuthRepository: AuthRepositoryProtocol {
    private let apiService: AuthApiServiceProtocol
    private let storageService: AuthStorageServiceProtocol
    
    init() {
        self.apiService = AuthApiService()
        self.storageService = AuthStorageService()
    }
    
    init(
        apiService: AuthApiServiceProtocol,
        storageService: AuthStorageServiceProtocol
    ) {
        self.apiService = apiService
        self.storageService = storageService
    }
    
    func signIn(email: String, password: String) async throws -> AuthTokens {
        let request = SignInRequest(email: email, password: password)
        let tokens = try await apiService.signIn(request: request)
        try await storageService.saveTokens(tokens)
        return tokens
    }
    
    func signUp(email: String, password: String, username: String) async throws -> AuthTokens {
        let request = SignUpRequest(email: email, password: password, username: username)
        let tokens = try await apiService.signUp(request: request)
        try await storageService.saveTokens(tokens)
        return tokens
    }
    
    func refreshToken() async throws -> AuthTokens {
        guard let currentTokens = try await storageService.getTokens() else {
            throw TokenError.invalidToken
        }
        
        let request = RefreshTokenRequest(refreshToken: currentTokens.refreshToken)
        let newTokens = try await apiService.refreshToken(request: request)
        try await storageService.saveTokens(newTokens)
        return newTokens
    }
    
    func logout() async throws {
        try await apiService.logout()
        try await storageService.deleteTokens()
    }
}