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
        var box: BoxPost
        let isNewBox: Bool
        var isLoggedIn = true
        var showAlert = false
        var alertMessage = ""
        
        // 添加输入验证
        var isValid: Bool {
            return !box.boxName.isEmpty && box.boxName.count >= 3
        }
        
        init(box: BoxPost? = nil) {
            self.box = box ?? BoxPost()
            self.isNewBox = box == nil
        }
        
        func commit() async {
            if isNewBox {
                await createBox()
            } else {
                await updateBox()
            }
        }
        
        @MainActor
        private func createBox() async {
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
                    throw NetworkError.unauthorized
                case 409:
                    throw NetworkError.conflict
                default:
                    throw NetworkError.unknown(message: "Failed to create box, status code\(httpResponse.statusCode)")
                }
            } catch let networkError as NetworkError {
                alertMessage = networkError.errorDescription
                showAlert = true
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
        
        @MainActor
        private func updateBox() async {
            // Implementation for updating an existing box
            // print("Updating box: \(box.name)")
        }
    }
}
