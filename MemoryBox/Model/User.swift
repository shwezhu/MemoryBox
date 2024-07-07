//
//  User.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import Foundation

class User: Identifiable {
    var id: UUID
    var name: String
    var avatarURL: URL?
    var boxes: [Box]
    
    init(name: String, avatarURL: URL? = nil) {
        self.id = UUID()
        self.name = name
        self.avatarURL = avatarURL
        self.boxes = []
    }
}

struct MockData {
    static let user = User(name: "David", avatarURL: URL(string: "https://example.com/avatar.jpg"))
    
    static let collaborator1 = User(name: "黄蕾蕾", avatarURL: URL(string: "https://example.com/alice.jpg"))
    static let collaborator2 = User(name: "朱有才", avatarURL: URL(string: "https://example.com/bob.jpg"))
    static let collaborator3 = User(name: "John", avatarURL: URL(string: "https://example.com/bob.jpg"))
    
    static let boxes: [Box] = [
        {
            let box = Box(name: "2023 杭州之行", isPrivate: false, creator: user)
            box.posts = [
                Post(title: "美食推荐", content: "今天发现了一家很棒的餐厅...", author: user),
                Post(title: "好看的的落日", content: "今天傍晚看到了特别好看的落日, 超级美...", author: user)
            ]
            box.collaborators = [collaborator1, collaborator2, collaborator3]
            return box
        }(),
        {
            let box = Box(name: "第一次约会", isPrivate: true, creator: user)
            box.posts = [
                Post(title: "吃饭饭篇", content: "这家的蒜蓉虾很好吃, 饿哦们吃了好多, 下次还回来...", author: user),
                Post(title: "趣事篇", content: "在公园散步的时候遇到了个小弟弟, 送了我们一朵花花, 太有爱了叭 (●′ω`●) ...", author: user)
            ]
            return box
        }()
    ]
    
    static func initialize() {
        user.boxes = boxes
    }
}
