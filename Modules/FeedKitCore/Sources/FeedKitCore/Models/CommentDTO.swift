import Foundation

struct CommentDTO: Decodable {
    let id: Int
    let postId: Int
    let author: String
    let avatar: String
    let text: String
    let createdAt: String
    let likesCount: Int
}