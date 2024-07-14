//
//  AddBoxView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-10.
//

import SwiftUI
import SwiftData

struct AddBoxView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $viewModel.box.name)
                }
                Section {
                    Toggle(isOn: $viewModel.box.isPrivate) {
                        Label {
                            Text(viewModel.box.isPrivate ? "Private" : "Public")
                                .foregroundColor(.primary)
                        } icon: {
                            Image(systemName: viewModel.box.isPrivate ? "lock.fill" : "lock.open.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .tint(.green)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: cancel) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: commit) {
                            Text("Add")
                        }
                        .disabled(viewModel.box.name.isEmpty)
                    }
                }
        }
    }
    
    private func commit() {
        // Task { try await viewModel.createBox() }
    }
    
    private func cancel() {
        dismiss()
    }
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Box.self, configurations: config)
//    
//    return AddBoxView()
//        .modelContainer(container)
//}
