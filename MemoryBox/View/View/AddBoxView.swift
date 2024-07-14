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
    
    @State private var box: Box

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $box.name)
                }
                Section {
                    Toggle(isOn: $box.isPrivate) {
                        Label {
                            Text(box.isPrivate ? "Private" : "Public")
                                .foregroundColor(.primary)
                        } icon: {
                            Image(systemName: box.isPrivate ? "lock.fill" : "lock.open.fill")
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
                        .disabled(box.name.isEmpty)
                    }
                }
        }
    }
    
    private func commit() {
        dismiss()
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
