import Foundation

public protocol ResponseSerializer<SerializedType> {
    associatedtype SerializedType: Sendable
    
    func serialize(_ data: Data, response: HTTPURLResponse) throws -> SerializedType
}