import Foundation

struct DataSerializer: ResponseSerializer {
    typealias SerializedType = Data

    func serialize(_ data: Data, response: HTTPURLResponse) throws -> Data {
        data
    }
}
