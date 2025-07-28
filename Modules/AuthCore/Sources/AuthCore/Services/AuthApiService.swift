import Foundation

protocol AuthApiServiceProtocol {
    func signIn(request: SignInRequest) async throws -> AuthTokens
    func signUp(request: SignUpRequest) async throws -> AuthTokens
    func refreshToken(request: RefreshTokenRequest) async throws -> AuthTokens
    func logout() async throws
}

final class AuthApiService: AuthApiServiceProtocol {
    func signIn(request: SignInRequest) async throws -> AuthTokens {
        // TODO: Implement sign in API call
        fatalError("Not implemented")
    }
    
    func signUp(request: SignUpRequest) async throws -> AuthTokens {
        // TODO: Implement sign up API call
        fatalError("Not implemented")
    }
    
    func refreshToken(request: RefreshTokenRequest) async throws -> AuthTokens {
        // TODO: Implement refresh token API call
        fatalError("Not implemented")
    }
    
    func logout() async throws {
        // TODO: Implement logout API call
        fatalError("Not implemented")
    }
}