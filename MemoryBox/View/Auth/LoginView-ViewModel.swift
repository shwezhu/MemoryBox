//
//  LoginView-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import Foundation

extension LoginView {
    
    @Observable
    class ViewModel {
        var email = ""
        var password = ""
        
        @MainActor
        func login() async throws {
            
        }
    }
}
