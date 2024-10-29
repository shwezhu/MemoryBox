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
            guard let url = URL(string: Config.createBoxUrl) else {
                throw NetworkError.invalidURL
            }
            
            // 从 UserDefaults 获取 JWT token
            guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
                // NetworkError(message: "No JWT token found")
                throw NetworkError.unauthorized
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // 编码 box 数据
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(box)
            
            //print(box)
            
            // 发送请求
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // NetworkError(message: "Invalid response")
                throw NetworkError.decodingError
            }
            
            //print(httpResponse.statusCode)
            
            switch httpResponse.statusCode {
            case 200...299:
                print("Box created successfully")
            case 400:
                throw NetworkError.badRequest
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.unknown
            }
        }
        
        @MainActor
        private func updateBox() async throws {
            // Implementation for updating an existing box
            // print("Updating box: \(box.name)")
        }
    }
}
