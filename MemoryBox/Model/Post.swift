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
    var imageURLs: [String]
    var author: User
    var createdAt: Date
    var editedAt: Date?
    
    init(title: String, content: String, imageURLs: [String] = [], author: User) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.imageURLs = imageURLs
        self.author = author
        self.createdAt = Date()
        self.editedAt = nil
    }
}
