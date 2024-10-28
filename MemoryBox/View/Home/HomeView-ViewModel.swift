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
                    let boxResponses = try await NetworkManager.shared.fetchBoxes()
                    boxes = boxResponses.map { response in
                        Box(
                            boxID: String(response.boxId),
                            
                            name: response.boxName,
                            isPrivate: response.isPrivate,
                            posts: [], // 仅获取Box, 服务端没有返回 Post
                            ownerID: String(response.ownerId),
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
