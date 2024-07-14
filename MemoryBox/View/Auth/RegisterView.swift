//
//  RegisterView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullname = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Register New Account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 36)
            VStack {
                TextField("Enter your email", text: $email)
                    .modifier(AuthTextFieldModifier())
                
                TextField("Enter your password", text: $password)
                    .modifier(AuthTextFieldModifier())
                
                TextField("Enter your fullname", text: $fullname)
                    .modifier(AuthTextFieldModifier())
                
                TextField("Enter your username", text: $username)
                    .modifier(AuthTextFieldModifier())
            }
            
            Button {
                
            } label: {
                Text("Sign Up")
                    .modifier(AuthButtonModifier())
            }
            .padding(.vertical)
            
            Spacer()
            Divider()
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundStyle(Color.black)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegisterView()
}
