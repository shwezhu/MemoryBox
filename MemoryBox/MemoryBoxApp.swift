//
//  MemoryBoxApp.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-05.
//

import SwiftUI

@main
struct MemoryBoxApp: App {
    // @State private var isLoggedIn = UserDefaults.standard.string(forKey: "jwtToken") != nil
    // Use @AppStorage to synchronize with UserDefaults automatically
    @AppStorage("jwtToken") private var jwtToken: String?

    var body: some Scene {
        WindowGroup {
            if jwtToken != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
