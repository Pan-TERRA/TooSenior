import Foundation
import SwiftData

@Model
public final class Post {
    public private(set) var id: Int
    public private(set) var title: String
    public private(set) var body: String
    public private(set) var mediaType: MediaType
    public private(set) var mediaUrl: URL?
    public private(set) var thumbnailUrl: URL?
    public private(set) var authorName: String
    public private(set) var authorAvatarURL: URL
    public private(set) var createdAt: Date
    public private(set) var commentCount: Int
    public private(set) var likesCount: Int
    
    @Relationship(deleteRule: .cascade)
    public private(set) var comments: [Comment] = []
    
    init(
        id: Int,
        title: String,
        body: String,
        mediaType: MediaType,
        mediaUrl: URL? = nil,
        thumbnailUrl: URL? = nil,
        authorName: String,
        authorAvatarURL: URL,
        createdAt: Date,
        commentCount: Int,
        likesCount: Int
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.mediaType = mediaType
        self.mediaUrl = mediaUrl
        self.thumbnailUrl = thumbnailUrl
        self.authorName = authorName
        self.authorAvatarURL = authorAvatarURL
        self.createdAt = createdAt
        self.commentCount = commentCount
        self.likesCount = likesCount
    }
    
    public enum MediaType: String, CaseIterable, Codable {
        case text = "text"
        case image = "image"
        case video = "video"
    }
}

extension Post {
    convenience init(dto: PostDTO) {
        self.init(
            id: dto.id,
            title: dto.title,
            body: dto.body,
            mediaType: MediaType(rawValue: dto.mediaType) ?? .text,
            mediaUrl: dto.mediaUrl.flatMap { URL(string: $0) },
            thumbnailUrl: dto.thumbnailUrl.flatMap { URL(string: $0) },
            authorName: dto.author,
            authorAvatarURL: URL(string: dto.avatar)!,
            createdAt: ISO8601DateFormatter().date(from: dto.createdAt) ?? Date(),
            commentCount: dto.commentCount,
            likesCount: dto.likesCount
        )
    }
}
