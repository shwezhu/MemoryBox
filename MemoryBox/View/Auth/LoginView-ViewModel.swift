//
//  LoginView-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import Foundation
import SwiftUI

extension LoginView {
    
    @Observable
    class ViewModel {
        var username = ""
        var password = ""
        var showAlert = false
        var alertMessage = ""
        var isLoggedIn = false
        
        @MainActor
        func login() async {
            do {
                guard let url = URL(string: Config.loginUrl) else {
                    throw URLError(.badURL)
                }
                
                let loginData = ["username": username, "password": password]
                let jsonData = try JSONEncoder().encode(loginData)
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                UserDefaults.standard.set(loginResponse.token, forKey: "jwtToken")
                UserDefaults.standard.set(loginResponse.userId, forKey: "userId")
                isLoggedIn = true
            } catch {
                alertMessage = "Login failed: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

struct LoginResponse: Codable {
    let token: String
    let userId: String
    let message: String
}
