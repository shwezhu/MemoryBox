//
//  HomeView-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-10-28.
//

import Foundation


extension HomeView {
    @Observable
    class ViewModel {
        var boxes: [Box] = []
        var isLoading: Bool = false
        var isLoggedIn = true
        var error: String? = nil
        var filteredBoxes: [Box] = []
        var searchText: String = "" {
            didSet {
                filterBoxes()
            }
        }
        
        private func filterBoxes() {
            if searchText.isEmpty {
                filteredBoxes = boxes
            } else {
                filteredBoxes = boxes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }

        func fetchBoxes() async {
            isLoading = true
            error = nil

            // Task ??
            Task {
                do {
                    guard let url = URL(string: "\(Config.baseUrl)/api/boxes") else {
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
                    
                    if httpResponse.statusCode != 200 {
                        if httpResponse.statusCode == 401 {
                            UserDefaults.standard.removeObject(forKey: "jwtToken")
                            UserDefaults.standard.removeObject(forKey: "userId")
                            isLoggedIn = false
                        } else {
                            throw NetworkError.badrequest
                        }
                    }
                    
                    let decoder = JSONDecoder()
                    let boxResponses = try decoder.decode([BoxResponse].self, from: data)

                    boxes = boxResponses.map { response in
                        Box(
                            boxID: String(response.boxId),
                            
                            name: response.boxName,
                            isPrivate: response.isPrivate,
                            posts: [], // 仅获取Box, 服务端没有返回 Post
                            ownerId: String(response.ownerId),
                            collaborators: []
                        )
                    }
                    filterBoxes() // 更新过滤后的结果
                } catch {
                    self.error = error.localizedDescription
                }
                isLoading = false
            }
        }
        
        
        
    }
}
