//
//  BoxDetailView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-07.
//

import SwiftUI

//struct BoxDetailView: View {
//    let boxName: String
//    let posts: [Post]
//    
//    var body: some View {
//        List {
//            ForEach(Array(posts.enumerated()), id: \.element.id) { index, post in
//                PostView(post: post)
//                    .listRowSeparator(.hidden, edges: index == 0 ? .top : .bottom)
//            }
//        }
//        .listStyle(.plain)
//        .navigationTitle(boxName)
//    }
//}

struct BoxDetailView: View {
    let boxName: String
    let posts: [Post]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(posts) { post in
                    PostView(post: post)
                    if post.id != posts.last?.id {
                        Divider()
                    }
                }
            }
        }
        .navigationTitle(boxName)
    }
}

#Preview {
    BoxDetailView(boxName: "2023杭州之行", posts: MockData.boxes[0].posts)
}
