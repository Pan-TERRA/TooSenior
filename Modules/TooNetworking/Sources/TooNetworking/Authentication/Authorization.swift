import Foundation

public enum Authorization: Sendable {
    case currentUser
    
    public var headerValue: String? {
        switch self {
        case .currentUser:
            return TokenHeaderManager.shared.authorizationHeader
        }
    }
}