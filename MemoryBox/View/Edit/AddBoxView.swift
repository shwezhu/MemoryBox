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
    @State private var box = Box()

    var body: some View {
        NavigationStack {
            BoxFormView(box: box)
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
                    }
                }
        }
    }
    
    private func commit() {
        if box.name.isEmpty {
            return
        }
        // context.insert(box)
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
