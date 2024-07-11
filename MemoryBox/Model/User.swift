//
//  User.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import Foundation
import SwiftData

@Model
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
//
//struct MockData {
//    static let user = User(name: "David", avatarURL: URL(string: "https://example.com/avatar.jpg"))
//    
//    static let collaborator1 = User(name: "黄蕾蕾", avatarURL: URL(string: "https://example.com/alice.jpg"))
//    static let collaborator2 = User(name: "朱有才", avatarURL: URL(string: "https://example.com/bob.jpg"))
//    static let collaborator3 = User(name: "John", avatarURL: URL(string: "https://example.com/bob.jpg"))
//    
//    static let urls = [
//        "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/e19fa93e872678fb08908fd096f87647.jpg",
//        "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/083220f0900ed1f222cee4a625202ec5.jpg",
//        "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/1473168901a05453e2925380ecdbfc7d.jpg",
//        "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/aefa5f11046572011338797e0365a566.jpg",
//    ]
//    
//    static let urls2 = ["https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/083220f0900ed1f222cee4a625202ec5.jpg"]
//    
//    static let urls3 = [
//        "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/e19fa93e872678fb08908fd096f87647.jpg",
//        "https://pub-2a6758f3b2d64ef5bb71ba1601101d35.r2.dev/blogs/2024/07/083220f0900ed1f222cee4a625202ec5.jpg",
//    ]
//    
//    static let boxes: [Box] = [
//        {
//            let box = Box(name: "2023 杭州之行", isPrivate: false, creator: user)
//            box.posts = [
//                Post(title: "好看的的落日", content: "今天傍晚看到了特别好看的落日, 超级美...", imageURLs: urls , author: user),
//                Post(title: "美食推荐", content: "今天发现了一家很棒的餐厅...", imageURLs: urls3, author: user),
//            ]
//            box.collaborators = [collaborator1, collaborator2, collaborator3]
//            return box
//        }(),
//        {
//            let box = Box(name: "第一次约会", isPrivate: true, creator: user)
//            box.posts = [
//                Post(title: "吃饭饭篇", content: "这家的蒜蓉虾很好吃, 饿哦们吃了好多, 下次还回来...", imageURLs: urls2, author: user),
//                Post(title: "趣事篇", content: "在公园散步的时候遇到了个小弟弟, 送了我们一朵花花, 太有爱了叭 (●′ω`●) ...", author: user)
//            ]
//            return box
//        }()
//    ]
//    
//    static func initialize() {
//        user.boxes = boxes
//    }
//}
