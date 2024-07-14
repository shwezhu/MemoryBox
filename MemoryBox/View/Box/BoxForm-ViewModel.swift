//
//  BoxForm-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import Foundation

extension BoxForm {
    @Observable
    class ViewModel {
        var box: Box
        let isNewBox: Bool
        
        init(box: Box? = nil) {
            self.box = box ?? Box(ownerID: "007")
            self.isNewBox = box == nil
        }
        
        var isValid: Bool {
            !box.name.isEmpty
        }
        
        func commit() async throws {
            if isNewBox {
                try await createBox()
            } else {
                try await updateBox()
            }
        }
        
        @MainActor
        private func createBox() async throws {
            // Implementation for creating a new box
            print("Creating new box: \(box.name)")
        }
        
        @MainActor
        private func updateBox() async throws {
            // Implementation for updating an existing box
            print("Updating box: \(box.name)")
        }
    }
}
