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
                            await viewModel.commit()
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.isValid)
                }
            }
            // 添加错误提示弹窗
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
            // 添加输入验证提示
            .overlay {
                if !viewModel.box.boxName.isEmpty && viewModel.box.boxName.count < 3 {
                    VStack {
                        Text("Box name must be at least 3 characters")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                        Spacer()
                    }
                    .padding(.top)
                }
            }
        }
    }
}
