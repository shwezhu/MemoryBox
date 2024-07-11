//
//  MemoryBoxApp.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-05.
//

import SwiftUI

@main
struct MemoryBoxApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [User.self, Box.self, Post.self])
    }
}
