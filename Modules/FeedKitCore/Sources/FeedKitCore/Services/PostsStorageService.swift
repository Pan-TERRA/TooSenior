import Foundation
import SwiftData

protocol PostsStorageServiceProtocol {
    func getPosts() async throws -> [Post]
    func savePosts(_ posts: [Post]) async throws

    func getComments(for postId: Int) async throws -> [Comment]
    func saveComments(_ comments: [Comment]) async throws
}

final class PostsStorageService: PostsStorageServiceProtocol {
    func getPosts() async throws -> [Post] {
        // TODO: Implement SwiftData retrieval
        fatalError("Not implemented")
    }

    func savePosts(_ posts: [Post]) async throws {
        // TODO: Implement SwiftData storage
        fatalError("Not implemented")
    }
    
    func getComments(for postId: Int) async throws -> [Comment] {
        // TODO: Implement SwiftData retrieval
        fatalError("Not implemented")
    }
    
    func saveComments(_ comments: [Comment]) async throws {
        // TODO: Implement SwiftData storage
        fatalError("Not implemented")
    }
}
