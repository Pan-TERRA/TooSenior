import Foundation

struct PostDTO: Decodable {
    let id: Int
    let title: String
    let body: String
    let mediaType: String
    let mediaUrl: String?
    let thumbnailUrl: String?
    let author: String
    let avatar: String
    let createdAt: String
    let commentCount: Int
    let likesCount: Int
}