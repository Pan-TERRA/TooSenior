import Foundation

public enum HTTPParameters: Sendable, Equatable, Hashable {
    public enum ContentType: Sendable, Equatable, Hashable {
        case json
        case multipart(boundary: String)

        public func toString() -> String {
            switch self {
            case .json:
                return "application/json"
            case let .multipart(boundary):
                return "multipart/form-data; boundary=\(boundary)"
            }
        }
    }

    case body(Data, ContentType)
    case query([String: String])
    case multipleValueFieldQuery([String: [String]])
    case bodyAndQuery(Data, ContentType, [String: String])
    case empty

    public static func multipart(parameters: MultipartParameters) -> HTTPParameters {
        return .body(parameters.multipartData, .multipart(boundary: parameters.boundary))
    }

    public static func multipartAndQuery(
        parameters: MultipartParameters,
        query: [String: String]
    ) -> HTTPParameters {
        return .bodyAndQuery(
            parameters.multipartData,
            .multipart(boundary: parameters.boundary),
            query
        )
    }
}