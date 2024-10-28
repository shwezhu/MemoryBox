//
//  HomeView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var context
    @State private var viewModel = ViewModel()
    @State private var isAddBoxSheetPresented = false
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                VStack {
                    Text(error)
                        .foregroundColor(.red)
                    Button("Retry") {
                        Task {
                            await viewModel.fetchBoxes()
                        }
                    }
                    .padding()
                }
            } else {
                boxGrid
            }
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Memory Boxes")
        .sheet(isPresented: $isAddBoxSheetPresented) {
            AddBoxView()
        }
        .overlay(alignment: .bottomLeading) {
            addBoxButton
        }
        .onAppear {
            /// TASK ???
            Task {
                await viewModel.fetchBoxes()
            }
        }
        .refreshable {
            await viewModel.fetchBoxes()
        }
    }
    
    private var boxGrid: some View {
        let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
        // LazyVGrid 不提供滚动功能
        return ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.boxes) { box in
                    NavigationLink(destination: BoxDetailView(boxName: box.name, posts: box.posts ?? [])) {
                        BoxView(box: box)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(10)
        }
    }
    
    private var addBoxButton: some View {
        Button {
            isAddBoxSheetPresented = true
        } label: {
            Label("New Box", systemImage: "plus")
                .fontWeight(.bold)
                .foregroundStyle(Color.black)
                .padding()
        }
    }
}
