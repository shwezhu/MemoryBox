//
//  HomeView-ViewModel.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-10-28.
//

import Foundation
import SwiftUI

extension HomeView {
    @Observable
    class ViewModel {
        var boxes: [Box] = []
        var isLoading: Bool = false
        var error: String? = nil
        var filteredBoxes: [Box] = []
        var searchText: String = "" {
            didSet {
                filterBoxes()
            }
        }
        var isAddBoxSheetPresented: Bool = false

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

            do {
                guard let url = URL(string: "\(Config.baseUrl)/api/boxes") else {
                    throw NetworkError.invalidURL
                }

                guard let token = AuthManager.token else {
                    throw NetworkError.noToken
                }

                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

                let (data, response) = try await URLSession.shared.data(for: request)

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.serverError(message: "Failed to fetch boxes invalid response.")
                }

                switch httpResponse.statusCode {
                case 200:
                    break
                case 401:
                    AuthManager.clearAuth()
                default:
                    throw NetworkError.serverError(message: "Failed to fetch boxes, status code: \(httpResponse.statusCode)")
                }

                let decoder = JSONDecoder()
                let boxResponses = try decoder.decode([BoxResponse].self, from: data)

                boxes = boxResponses.map { response in
                    Box(
                        boxID: String(response.boxId),
                        name: response.boxName,
                        isPrivate: response.isPrivate,
                        posts: [], // Posts are not returned in this API call
                        ownerId: String(response.ownerId),
                        collaborators: []
                    )
                }
                filterBoxes() // Update filtered results
            } catch let networkError as NetworkError {
                self.error = networkError.errorDescription
            } catch {
                self.error = error.localizedDescription
            }
            isLoading = false
        }
    }
}

