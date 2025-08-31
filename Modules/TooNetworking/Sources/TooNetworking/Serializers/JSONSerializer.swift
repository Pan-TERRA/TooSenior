import Foundation

public struct JSONSerializer<T: Codable & Sendable>: ResponseSerializer {
    public typealias SerializedType = T
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    public func serialize(_ data: Data, response: HTTPURLResponse) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.serializationError(error)
        }
    }
}