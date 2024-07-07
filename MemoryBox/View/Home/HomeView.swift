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
            VStack {
                BoxGridView(boxes: boxes)
            }
            .searchable(text: $searchText)
            .navigationTitle("Memory Boxes")
            .overlay(alignment: .bottomLeading) {
                addBoxButton
            }
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
