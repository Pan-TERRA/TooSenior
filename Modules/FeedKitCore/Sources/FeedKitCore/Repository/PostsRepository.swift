import Foundation

protocol PostsRepositoryProtocol {
    func getPosts() async throws -> [Post]
    func getComments(for postId: Int) async throws -> [Comment]
    
    func fetchPosts(page: Int, limit: Int) async throws -> [Post]
    func fetchComments(for postId: Int, page: Int, limit: Int) async throws -> [Comment]
}

public final class PostsRepository: PostsRepositoryProtocol {
    private let apiService: PostsApiServiceProtocol
    private let storageService: PostsStorageServiceProtocol
    
    init() {
        self.apiService = PostsApiService()
        self.storageService = PostsStorageService()
    }
    
    init(
        apiService: PostsApiServiceProtocol,
        storageService: PostsStorageServiceProtocol
    ) {
        self.apiService = apiService
        self.storageService = storageService
    }
    
    public func getPosts() async throws -> [Post] {
        return try await storageService.getPosts()
    }
    
    public func getComments(for postId: Int) async throws -> [Comment] {
        return try await storageService.getComments(for: postId)
    }
    
    public func fetchPosts(page: Int, limit: Int) async throws -> [Post] {
        let postDTOs = try await apiService.fetchPosts(page: page, limit: limit)
        let posts = postDTOs.map { Post(dto: $0) }
        
        try await storageService.savePosts(posts)
        return posts
    }
    
    public func fetchComments(for postId: Int, page: Int, limit: Int) async throws -> [Comment] {
        let commentDTOs = try await apiService.fetchComments(for: postId, page: page, limit: limit)
        let comments = commentDTOs.map { Comment(dto: $0) }
        
        try await storageService.saveComments(comments)
        return comments
    }
}
