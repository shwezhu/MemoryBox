import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Register New Account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical, 36)
            
            // 头像选择区域
            VStack {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .onTapGesture {
                            showImagePicker = true
                        }
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Image(systemName: "camera")
                                .font(.title)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            showImagePicker = true
                        }
                }
            }
            .padding(.bottom, 24)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Text("Email")
                        .font(.caption)
                        .frame(width: 50)

                    TextField("Enter your email", text: $viewModel.email)
                        .modifier(AuthTextFieldModifier())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                HStack(alignment: .center) {
                    Text("Password")
                        .font(.caption)
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(AuthTextFieldModifier())
                }
                
                HStack(alignment: .center) {
                    Text("Full Name")
                        .font(.caption)
                    TextField("Enter your fullname", text: $viewModel.fullname)
                        .modifier(AuthTextFieldModifier())
                }
                
                HStack(alignment: .center) {
                    Text("Username")
                        .font(.caption)
                    TextField("Enter your username", text: $viewModel.username)
                        .modifier(AuthTextFieldModifier())
                        .autocapitalization(.none)
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.vertical)
            } else {
                Button {
                    Task {
                        await viewModel.createUser()
                        dismiss()
                    }
                } label: {
                    Text("Sign Up")
                        .modifier(AuthButtonModifier())
                }
                .padding(.vertical)
                .disabled(!viewModel.isFormValid)
                .opacity(viewModel.isFormValid ? 1.0 : 0.5)
            }
            
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
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

