import Foundation

enum SignInError: Error, Equatable {
    case invalidCredentials
    case accountLocked
    case accountNotFound
    case networkError
    case invalidResponse
    case unknownError(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password"
        case .accountLocked:
            return "Account is temporarily locked"
        case .accountNotFound:
            return "Account not found"
        case .networkError:
            return "Network connection error"
        case .invalidResponse:
            return "Invalid server response"
        case .unknownError(let message):
            return "Unknown error: \(message)"
        }
    }
}

enum SignUpError: Error, Equatable {
    case emailAlreadyExists
    case weakPassword
    case invalidEmail
    case networkError
    case invalidResponse
    case unknownError(String)
    
    var localizedDescription: String {
        switch self {
        case .emailAlreadyExists:
            return "Email already registered"
        case .weakPassword:
            return "Password is too weak"
        case .invalidEmail:
            return "Invalid email format"
        case .networkError:
            return "Network connection error"
        case .invalidResponse:
            return "Invalid server response"
        case .unknownError(let message):
            return "Unknown error: \(message)"
        }
    }
}

enum TokenError: Error, Equatable {
    case tokenExpired
    case tokenRefreshFailed
    case keychainError
    case invalidToken
    case unknownError(String)
    
    var localizedDescription: String {
        switch self {
        case .tokenExpired:
            return "Session expired"
        case .tokenRefreshFailed:
            return "Failed to refresh session"
        case .keychainError:
            return "Secure storage error"
        case .invalidToken:
            return "Invalid authentication token"
        case .unknownError(let message):
            return "Unknown error: \(message)"
        }
    }
}