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
        var username = ""
        var password = ""
        var showAlert = false
        var alertMessage = ""

        func login() async {
            do {
                guard let url = URL(string: Config.loginUrl) else {
                    throw NetworkError.invalidURL
                }

                let loginData = ["username": username, "password": password]
                let jsonData = try JSONEncoder().encode(loginData)

                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData

                let (data, response) = try await URLSession.shared.data(for: request)

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }

                switch httpResponse.statusCode {
                case 200:
                    break
                case 400:
                    throw NetworkError.badRequest
                case 401:
                    throw NetworkError.invalidCredentials
                default:
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                }

                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)

                // Save token and user ID using UserDefaults
                UserDefaults.standard.set(loginResponse.token, forKey: "jwtToken")
                UserDefaults.standard.set(loginResponse.userId, forKey: "userId")
            } catch let networkError as NetworkError {
                alertMessage = networkError.localizedDescription
                showAlert = true
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

