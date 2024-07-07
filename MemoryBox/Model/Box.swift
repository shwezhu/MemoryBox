//
//  Box.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import Foundation

class Box: Identifiable {
    var id: UUID
    var name: String
    var isPrivate: Bool
    var posts: [Post]
    let creator: User
    var collaborators: [User]
    
    init(name: String, isPrivate: Bool = true, creator: User) {
        self.id = UUID()
        self.name = name
        self.isPrivate = isPrivate
        self.posts = []
        self.creator = creator
        self.collaborators = []
    }
    
    var postCount: Int {
        posts.count
    }
    
    func canEditCollaborators(user: User) -> Bool {
        user.id == creator.id
    }
    
    func addCollaborator(user: User) {
        if !collaborators.contains(where: { $0.id == user.id }) {
            // collaborators.append(user)
        }
    }
    
    func removeCollaborator(user: User) {
        // collaborators.removeAll(where: { $0.id == user.id })
    }
}
