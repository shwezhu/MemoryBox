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
        var errorMessage: String? = nil
        
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
        func createUser() async throws {
            //print("Starting user creation process")
            isLoading = true
            errorMessage = nil
            
            do {
                // 如果用户选择了头像，先上传头像
                if let image = selectedImage {
                    //print("User selected an avatar image, preparing to upload")
                    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                        //print("Failed to convert image to JPEG data")
                        throw URLError(.badURL)
                    }
                    let fileName = "\(UUID().uuidString).jpg"
                    //print("Requesting presigned URL for file: \(fileName)")
                    guard let response = try await getPresignedUrl(fileName: fileName, fileType: "image/jpeg") else {
                        print("Failed to get presigned URL")
                        throw URLError(.badServerResponse)
                    }

                    //print("Uploading image to presigned URL")
                    try await uploadImage(data: imageData, to: response.presignedUrl)
                    avatarURL = response.imageUrl
                    //print("Image uploaded successfully, avatar URL: \(avatarURL ?? "N/A")")
                } else {
                    print("No avatar image selected")
                }
                
                let registrationData: [String: Any] = [
                    "fullname": fullname,
                    "email": email,
                    "username": username,
                    "password": password,
                    "avatarURL": avatarURL ?? ""
                ]
                
                //print("Attempting to register user with data: \(registrationData)")
                try await registerUser(with: registrationData)
                //print("User registration successful")
            } catch {
                //print("Error during user creation: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
        
        private func getPresignedUrl(fileName: String, fileType: String) async throws -> PresignedUrlResponse? {
            //print("Getting presigned URL for file: \(fileName), type: \(fileType)")
            var components = URLComponents(string: "http://localhost:5190/api/auth/presigned-url")!

            components.queryItems = [
                URLQueryItem(name: "fileName", value: fileName),
                URLQueryItem(name: "fileType", value: fileType)
            ]
            
            guard let url = components.url else {
                print("Failed to construct URL for presigned URL request")
                throw URLError(.badURL)
            }
            
            //print("Sending request to: \(url.absoluteString)")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                print("Received invalid response: \(response)")
                throw URLError(.badServerResponse)
            }
            
            let presignedUrlResponse = try JSONDecoder().decode(PresignedUrlResponse.self, from: data)
            //print("Received presigned URL: \(presignedUrlResponse.presignedUrl)")
            return presignedUrlResponse
        }
        
        private func uploadImage(data: Data, to urlString: String) async throws {
            //print("Uploading image to URL: \(urlString)")
            guard let url = URL(string: urlString) else {
                print("Invalid upload URL")
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 204 else {
                print("Received invalid response for image upload: \(response)")
                throw URLError(.badServerResponse)
            }
            
            //print("Image upload successful")
        }
        
        private func registerUser(with data: [String: Any]) async throws {
            //print("Registering user with data: \(data)")
            guard let url = URL(string: "http://localhost:5190/api/auth/register") else {
                print("Invalid registration URL")
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // 将字典转换为 JSON 数据
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            request.httpBody = jsonData
            
            //print("Sending registration request to: \(url.absoluteString)")
            let (responseData, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                //print("Received invalid response type")
                throw URLError(.badServerResponse)
            }
            
            //print("Received response with status code: \(httpResponse.statusCode)")
            if 200..<300 ~= httpResponse.statusCode {
                //print("Registration successful")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: responseData) as? [String: Any],
                    let message = json["message"] as? String {
                    print("Registration failed with message: \(message)")
                    throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                } else {
                    print("Failed to parse error response")
                    throw URLError(.badServerResponse)
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
