//
//  Post.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import Foundation
import SwiftData

struct Post: Identifiable { // ‘ForEach’ requires xxx conform to ‘Identifiable’
    var id: String
    var title: String
    var content: String
    var imageURLs: [String]
    var creator: User
    var createdAt: Date
    var editedAt: Date?
    
    init(id: String, title: String, content: String, imageURLs: [String] = [], creator: User) {
        self.id = id
        self.title = title
        self.content = content
        self.imageURLs = imageURLs
        self.creator = creator
        self.createdAt = Date()
        self.editedAt = nil
    }
}
