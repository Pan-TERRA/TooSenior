import Foundation

protocol AuthStorageServiceProtocol {
    func saveTokens(_ tokens: AuthTokens) async throws
    func getTokens() async throws -> AuthTokens?
    func deleteTokens() async throws
}

final class AuthStorageService: AuthStorageServiceProtocol {
    func saveTokens(_ tokens: AuthTokens) async throws {
        // TODO: Implement keychain storage
        fatalError("Not implemented")
    }
    
    func getTokens() async throws -> AuthTokens? {
        // TODO: Implement keychain retrieval
        fatalError("Not implemented")
    }
    
    func deleteTokens() async throws {
        // TODO: Implement keychain deletion
        fatalError("Not implemented")
    }
}