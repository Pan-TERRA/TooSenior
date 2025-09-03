import Foundation

public struct MultipartParameters: Sendable {
    public let multipartData: Data
    public let boundary: String
    
    public init(multipartData: Data, boundary: String) {
        self.multipartData = multipartData
        self.boundary = boundary
    }
}