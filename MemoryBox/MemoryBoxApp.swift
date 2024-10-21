//
//  MemoryBoxApp.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-05.
//

import SwiftUI

@main
struct MemoryBoxApp: App {
    @State private var isLoggedIn = UserDefaults.standard.string(forKey: "jwtToken") != nil
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
