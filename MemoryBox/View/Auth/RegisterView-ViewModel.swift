//
//  RegisterView-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import Foundation

extension RegisterView {
    @Observable
    class ViewModel {
        var fullname = ""
        var email = ""
        var username = ""
        var password = ""
        
        /// guarantee createUser() will run on the main thread.
        @MainActor
        func createUser() async throws {
            
        }
    }
}
