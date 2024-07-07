//
//  Post.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import Foundation

// ‘ForEach’ requires xxx conform to ‘Identifiable’
class Post: Identifiable {
    var id: UUID
    var title: String
    var content: String
    var imageURL: URL?
    var author: User
    var createdAt: Date
    var editedAt: Date?
    
    init(title: String, content: String, imageURL: URL? = nil, author: User) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.author = author
        self.createdAt = Date()
        self.editedAt = nil
    }
}
