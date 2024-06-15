//
//  SignUpView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel = SignUpViewModel()
    @EnvironmentObject var sessionManager: SharedSessionManager
    
    @State var userName = ""
    @State var userEmail = ""
    @State var userPassword = ""
    @State var userConfirmPassword = ""
    
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var loading: Bool = false
    
    var body: some View {
        VStack {
            Text("Sign up")
                .font(.largeTitle)
                .padding(.bottom, 40)

            TextField("Name", text: $userName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)

            
            TextField("Email", text: $userEmail)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)

            SecureField("Password", text: $userPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            SecureField("Confirm password", text: $userConfirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button {
                signUpButtonTapped()
            } label: {
                HStack(spacing: 8) {
                    Text("Create Account")
                    if loading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
                .padding(.all, 8)
                .padding(.horizontal, 70)
                
            }
            .buttonStyle(.borderedProminent)
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Sign Up Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
    }
    
    private func signUpButtonTapped() {
        loading = true
        Task {
            await viewModel.createAccount(name: userName, email: userEmail, password: userPassword, confirmPassword: userConfirmPassword) { success, message in
                DispatchQueue.main.async {
                    loading = false
                    if !success {
                        alertMessage = message
                        showingAlert = true
                        return
                    }
                    sessionManager.isUserSessionActive = true
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
