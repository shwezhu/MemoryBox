//
//  Box.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import Foundation
import SwiftData

struct Box: Identifiable {
    var boxID: String?
    var name: String = ""
    var isPrivate: Bool = true
    var posts: [Post]?
    let ownerID: String
    var collaborators: [User]?
    
    var id: String {
        boxID ?? NSUUID().uuidString
    }
    
    var postCount: Int {
        posts?.count ?? 0
    }
    
//    func canEditCollaborators(user: User) -> Bool {
//       //  user.id == ownerID
//    }
    
//    func addCollaborator(user: User) {
//        if !collaborators.contains(where: { $0.id == user.id }) {
//            // collaborators.append(user)
//        }
//    }
//    
//    func removeCollaborator(user: User) {
//        // collaborators.removeAll(where: { $0.id == user.id })
//    }
}

struct BoxResponse: Codable {
    let boxId: Int
    let boxName: String
    let isPrivate: Bool
    let ownerId: Int
    let createdDate: String
    let owner: OwnerResponse?
}

struct OwnerResponse: Codable {
    let fullName: String
    let profilePictureUrl: String
}

