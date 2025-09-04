import Foundation
import TooNetworking

protocol PostsApiServiceProtocol {
    func fetchPosts(page: Int, limit: Int) async throws -> [PostDTO]
    func fetchComments(for postId: Int, page: Int, limit: Int) async throws -> [CommentDTO]
}

final class PostsApiService: PostsApiServiceProtocol {
    private let networkClient: NetworkClient
    private let pageSize: Int
    
    init(networkClient: NetworkClient, pageSize: Int) {
        self.networkClient = networkClient
        self.pageSize = pageSize
    }
    
    convenience init() {
        self.init(
            networkClient: NetworkClientFactory.infiniteFeedAPI(),
            pageSize: 10
        )
    }
    
    func fetchPosts(page: Int, limit: Int) async throws -> [PostDTO] {
        let request = HTTPRequest.build {
            Path("/api/posts")
            Method(.get)
            QueryParameters([
                "_page": String(page),
                "_limit": String(limit)
            ])
        }
        
        let response = try await networkClient.perform(
            request: request,
            serializer: JSONSerializer<[PostDTO]>()
        )
        
        return response.value
    }
    
    func fetchComments(for postId: Int, page: Int, limit: Int) async throws -> [CommentDTO] {
        let request = HTTPRequest.build {
            Path("/api/posts/\(postId)/comments")
            Method(.get)
            QueryParameters([
                "_page": String(page),
                "_limit": String(limit)
            ])
        }
        
        let response = try await networkClient.perform(
            request: request,
            serializer: JSONSerializer<[CommentDTO]>()
        )
        
        return response.value
    }
}
