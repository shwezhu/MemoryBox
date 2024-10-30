//
//  LoginView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            Spacer()
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 36)
            VStack {
                TextField("Enter your username", text: $viewModel.username)
                    .modifier(AuthTextFieldModifier())

                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(AuthTextFieldModifier())
            }

            NavigationLink(destination: EmptyView()) {
                Text("Forgot your password")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .padding(.trailing, 28)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }

            Button {
                Task {
                    await viewModel.login()
                }
            } label: {
                Text("Login")
                    .modifier(AuthButtonModifier())
            }

            Spacer()
            Divider()
            NavigationLink(destination: RegisterView()) {
                HStack {
                    Text("Don't have an account?")
                    Text("Sign Up")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundColor(.black)
            }
            .padding(.vertical, 16)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Login Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

