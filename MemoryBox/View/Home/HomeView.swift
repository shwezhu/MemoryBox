//
//  HomeView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("Memory Boxes")
                .searchable(text: $viewModel.searchText)
                .sheet(isPresented: $viewModel.isAddBoxSheetPresented) {
                    AddBoxView()
                }
                .overlay(alignment: .bottomLeading) {
                    addBoxButton
                }
                .task {
                    await viewModel.fetchBoxes()
                }
                .refreshable {
                    await viewModel.fetchBoxes()
                }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.error {
            VStack {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
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

    private var boxGrid: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        // LazyVGrid 不提供滚动功能
        return ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.filteredBoxes) { box in
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
            viewModel.isAddBoxSheetPresented = true
        } label: {
            Label("New Box", systemImage: "plus")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
        }
    }
}


