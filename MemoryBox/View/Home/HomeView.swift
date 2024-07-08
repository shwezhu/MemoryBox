//
//  HomeView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-06.
//

import SwiftUI

struct HomeView: View {
    @State private var isAddReminderDialogPresented = false
    @State private var searchText = ""
    let boxes = MockData.boxes
    
    var body: some View {
        NavigationStack {
            boxGrid
                .searchable(text: $searchText)
                .navigationTitle("Memory Boxes")
                .overlay(alignment: .bottomLeading) {
                    addBoxButton
                }
        }
    }
    
    private var boxGrid: some View {
        let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
        return ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(boxes) { box in
                    NavigationLink(destination: BoxDetailView(boxName: box.name, posts: box.posts)) {
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
            isAddReminderDialogPresented = true
        } label: {
            Label("New Box", systemImage: "plus")
                .fontWeight(.bold)
                .padding()
        }
    }
}

#Preview {
    HomeView()
}
