import Foundation

public struct EmptySerializer: ResponseSerializer {
    public typealias SerializedType = Void
    
    public init() {}
    
    public func serialize(_ data: Data, response: HTTPURLResponse) throws -> Void {
        return ()
    }
}