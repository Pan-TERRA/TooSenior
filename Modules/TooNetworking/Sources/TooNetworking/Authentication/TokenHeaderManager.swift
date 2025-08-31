import Foundation

public final class TokenHeaderManager: @unchecked Sendable {
    public static let shared = TokenHeaderManager()
    
    private let queue = DispatchQueue(label: "TokenHeaderManager")
    private var _currentToken: String?
    
    private init() {}
    
    public var currentToken: String? {
        queue.sync { _currentToken }
    }
    
    public func updateToken(_ token: String?) {
        queue.sync { self._currentToken = token }
    }
    
    public func clearToken() {
        queue.sync { self._currentToken = nil }
    }
    
    public var authorizationHeader: String? {
        queue.sync { 
            guard let token = _currentToken else { return nil }
            return "Bearer \(token)"
        }
    }
}