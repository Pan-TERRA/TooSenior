import Foundation

public enum NetworkError: Error, Sendable {
    case invalidURL(String)
    case noData
    case invalidResponse
    case unauthorized
    case twoFactorRequired(TwoFactorChallenge)
    case serverError(Int, Data?)
    case serializationError(Error)
    case tokenRefreshFailed
    case noInternetConnection
    case timeout
    case cancelled
    case unknown(Error)
}