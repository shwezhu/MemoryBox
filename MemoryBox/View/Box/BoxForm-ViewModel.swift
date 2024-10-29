//
//  BoxForm-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import Foundation
//
//struct NetworkError: Error {
//    let message: String
//}

extension BoxForm {
    @Observable
    class ViewModel {
        var box: BoxPost
        let isNewBox: Bool
        var isLoggedIn = true
        var error: String? = nil
        
        init(box: BoxPost? = nil) {
            self.box = box ?? BoxPost()
            self.isNewBox = box == nil
        }
        
        var isValid: Bool {
            !box.boxName.isEmpty
        }
        
        func commit() async throws {
            if isNewBox {
                try await createBox()
            } else {
                try await updateBox()
            }
        }
        
        /// guarantee createBox() will run on the main thread.
        @MainActor
        private func createBox() async throws {
            do {
                guard let url = URL(string: Config.createBoxUrl) else {
                    throw NetworkError.invalidURL
                }
                
                guard let token = AuthManager.token else {
                    throw NetworkError.noToken
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let encoder = JSONEncoder()
                request.httpBody = try encoder.encode(box)
                let (_, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.decodingError
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    break
                case 400:
                    throw NetworkError.badRequest
                case 401:
                    AuthManager.clearAuth()
                default:
                    throw NetworkError.unknown
                }
            } catch let networkError as NetworkError {
                self.error = networkError.localizedDescription
            } catch {
                self.error = error.localizedDescription
            }
        }
        
        @MainActor
        private func updateBox() async throws {
            // Implementation for updating an existing box
            // print("Updating box: \(box.name)")
        }
    }
}
