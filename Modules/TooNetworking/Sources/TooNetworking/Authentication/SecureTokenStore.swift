import Foundation

public protocol SecureTokenStoreProtocol: Actor {
    func getToken() async -> String?
    func setToken(_ token: String?) async
    func clearToken() async
    func getAuthorizationHeader() async -> String?
}

public actor SecureTokenStore: SecureTokenStoreProtocol {
    public static let shared = SecureTokenStore()
    
    private var currentToken: String?
    
    private init() {}
    
    public func getToken() async -> String? {
        return currentToken
    }
    
    public func setToken(_ token: String?) async {
        currentToken = token
    }
    
    public func clearToken() async {
        currentToken = nil
    }
    
    public func getAuthorizationHeader() async -> String? {
        guard let token = currentToken else { return nil }
        return "Bearer \(token)"
    }
}