import Foundation

public struct TwoFactorChallenge: Sendable {
    public let verificationMethods: [VerificationMethod]
    public let originalRequest: NetworkRequest
    
    public init(verificationMethods: [VerificationMethod], originalRequest: NetworkRequest) {
        self.verificationMethods = verificationMethods
        self.originalRequest = originalRequest
    }
}

public enum VerificationMethod: String, Sendable, CaseIterable {
    case sms
    case email
    case authenticatorApp = "totp"
}

public struct VerificationCredential: Sendable {
    public let method: VerificationMethod
    public let code: String
    
    public init(method: VerificationMethod, code: String) {
        self.method = method
        self.code = code
    }
}