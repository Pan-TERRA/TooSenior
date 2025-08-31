import Foundation

public enum Authorization: Sendable {
    case currentUser
    
    var headerValue: String? {
        switch self {
        case .currentUser:
            return TokenHeaderManager.shared.authorizationHeader
        }
    }
}