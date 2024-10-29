//
//  BoxForm.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import SwiftUI

struct BoxForm: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $viewModel.box.boxName)
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
            .navigationTitle(viewModel.isNewBox ? "Add Box" : "Update Box")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(viewModel.isNewBox ? "Add" : "Update") {
                        Task {
                            try await viewModel.commit()
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.isValid)
                }
            }
        }
    }
}
