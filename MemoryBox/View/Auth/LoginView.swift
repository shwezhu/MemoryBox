//
//  LoginView.swift
//  MemoryBox
//
//  Created by David Zhu on 2024-07-14.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 36)
            VStack {
                TextField("Enter your username", text: $username)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 26)
                
                TextField("Enter your password", text: $password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 26)
            }
            
            NavigationLink(destination: EmptyView()) {
                Text("Forgot your password")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .padding(.trailing, 28)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Button {
                
            } label: {
                Text("Login")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .frame(width: 352, height: 44)
                    .background(Color(.black))
                    .cornerRadius(10)
            }
            Spacer()
            Divider()
            NavigationLink(destination: Text("register view")) {
                HStack {
                    Text("Don't have an account?")
                    Text("Sign Up")
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
    LoginView()
}
