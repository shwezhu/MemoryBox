//
//  BoxForm-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import Foundation

extension AddBoxView {
    @Observable
    class ViewModel {
        var box: Box = Box(ownerID: "007")
        
        @MainActor
        func createBox() async throws {
            // ...
        }
    }
}

