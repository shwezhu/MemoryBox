//
//  NetworkManager.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-10-28.
//

import Foundation

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case badrequest
    case unknown
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://localhost:5190"
    
    // Why use @MainActor ????
    @MainActor
    func fetchBoxes() async throws -> [BoxResponse] {
        guard let url = URL(string: "\(baseURL)/api/boxes") else {
            throw NetworkError.invalidURL
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            throw NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No JWT token found"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
//        // 将 Data 转换为 String
//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("响应 JSON: \(jsonString)")
//        } else {
//            print("无法将 data 转换为字符串。")
//        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200:
            let decoder = JSONDecoder()
            return try decoder.decode([BoxResponse].self, from: data)
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.unknown
        }
    }
}
