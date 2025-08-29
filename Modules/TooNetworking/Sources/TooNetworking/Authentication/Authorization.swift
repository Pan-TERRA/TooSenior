import Foundation

public enum Authorization: Sendable {
    case currentUser
    
    var headerValue: String? {
        switch self {
        case .currentUser:
            return TokenManager.shared.currentAccessToken.map { "Bearer \($0)" }
        }
    }
}