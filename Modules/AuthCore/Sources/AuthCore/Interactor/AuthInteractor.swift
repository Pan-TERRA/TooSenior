import Foundation

public protocol AuthInteractorProtocol {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String, username: String) async throws
    func logout() async throws
    func isAuthenticated() async -> Bool
}

public final class AuthInteractor: AuthInteractorProtocol {
    private let repository: AuthRepositoryProtocol
    
    public init() {
        self.repository = AuthRepository()
    }
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    public func signIn(email: String, password: String) async throws {
        _ = try await repository.signIn(email: email, password: password)
    }
    
    public func signUp(email: String, password: String, username: String) async throws {
        _ = try await repository.signUp(email: email, password: password, username: username)
    }
    
    public func logout() async throws {
        try await repository.logout()
    }
    
    public func isAuthenticated() async -> Bool {
        // TODO: Check if valid tokens exist and are not expired
        return false
    }
}