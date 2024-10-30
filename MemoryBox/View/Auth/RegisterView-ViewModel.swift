import Foundation
import SwiftUI

extension RegisterView {
    @Observable
    class ViewModel {
        var fullname = ""
        var email = ""
        var username = ""
        var password = ""
        var selectedImage: UIImage? = nil
        var avatarURL: String? = nil
        var isLoading: Bool = false
        var showAlert = false
        var alertMessage: String = ""
        
        var isFormValid: Bool {
            let isValid = !fullname.isEmpty &&
                   !email.isEmpty && isValidEmail(email) &&
                   !username.isEmpty &&
                   !password.isEmpty
            return isValid
        }
        
        private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
            let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValid = predicate.evaluate(with: email)
            return isValid
        }
        
        @MainActor
        func createUser() async {
            isLoading = true
            
            do {
                if let image = selectedImage {
                    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                        throw NetworkError.invalidURL
                    }
                    let fileName = "\(UUID().uuidString).jpg"
                    guard let response = try await getPresignedUrl(fileName: fileName, fileType: "image/jpeg") else {
                        throw NetworkError.invalidResponse
                    }
                    // `try` is required by SwiftUI syntax when call a function that may throw exception,
                    // `do catch` will handle any thrown errors.
                    try await uploadImage(data: imageData, to: response.presignedUrl)
                    avatarURL = response.imageUrl
                }
                
                let registrationData: [String: Any] = [
                    "fullname": fullname,
                    "email": email,
                    "username": username,
                    "password": password,
                    "avatarURL": avatarURL ?? ""
                ]
                
                try await registerUser(with: registrationData)
            } catch let networkError as NetworkError {
                alertMessage = networkError.errorDescription
                showAlert = true
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
            }
            
            isLoading = false
        }
        
        private func getPresignedUrl(fileName: String, fileType: String) async throws -> PresignedUrlResponse? {
            var components = URLComponents(string: "\(Config.host)/api/auth/presigned-url")!

            components.queryItems = [
                URLQueryItem(name: "fileName", value: fileName),
                URLQueryItem(name: "fileType", value: fileType)
            ]
            
            guard let url = components.url else {
                throw NetworkError.invalidURL
            }
            
            //print("Sending request to: \(url.absoluteString)")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = (response as? HTTPURLResponse), 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(message: "Failed to get presigned url, statusCode: \(response as? HTTPURLResponse)?.statusCode ?? -1")
            }

            let presignedUrlResponse = try JSONDecoder().decode(PresignedUrlResponse.self, from: data)
            
            return presignedUrlResponse
        }
        
        private func uploadImage(data: Data, to urlString: String) async throws {
            guard let url = URL(string: urlString) else {
                throw NetworkError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = (response as? HTTPURLResponse), 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(message: "Failed to upload image, statusCode: \(response as? HTTPURLResponse)?.statusCode ?? -1")
            }
        }
        
        private func registerUser(with data: [String: Any]) async throws {
            guard let url = URL(string: "\(Config.host)/api/auth/register") else {
                throw NetworkError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            request.httpBody = jsonData
            
            let (responseData, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                if let json = try? JSONSerialization.jsonObject(with: responseData) as? [String: Any],
                   let message = json["message"] as? String {
                    throw NetworkError.serverError(message: "Failed to register user: \(message)")
                } else {
                    throw NetworkError.invalidResponse
                }
            }
        }
    }
    
    // 定义响应结构体
    struct PresignedUrlResponse: Codable {
        let presignedUrl: String
        let imageUrl: String
    }
    
    struct ErrorResponse: Codable {
        let message: String
    }
}
