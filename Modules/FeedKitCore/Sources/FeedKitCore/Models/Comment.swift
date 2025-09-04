import Foundation
import SwiftData

@Model
public final class Comment {
    public private(set) var id: Int
    public private(set) var postId: Int
    public private(set) var authorName: String
    public private(set) var authorAvatarURL: URL
    public private(set) var text: String
    public private(set) var createdAt: Date
    public private(set) var likesCount: Int
    
    public private(set) var post: Post?
    
    init(
        id: Int,
        postId: Int,
        authorName: String,
        authorAvatarURL: URL,
        text: String,
        createdAt: Date,
        likesCount: Int
    ) {
        self.id = id
        self.postId = postId
        self.authorName = authorName
        self.authorAvatarURL = authorAvatarURL
        self.text = text
        self.createdAt = createdAt
        self.likesCount = likesCount
    }
}

extension Comment {
    convenience init(dto: CommentDTO) {
        self.init(
            id: dto.id,
            postId: dto.postId,
            authorName: dto.author,
            authorAvatarURL: URL(string: dto.avatar)!,
            text: dto.text,
            createdAt: ISO8601DateFormatter().date(from: dto.createdAt) ?? Date(),
            likesCount: dto.likesCount
        )
    }
}
