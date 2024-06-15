//
//  LoginView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @EnvironmentObject var sessionManager: SharedSessionManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var loading: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("JorgeMeds 💊")
                    .font(.largeTitle)
                    .padding(.bottom, 40)

                TextField(String(localized: "Email"), text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField(String(localized: "Password"), text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button {
                    loginButtonTapped()
                } label: {
                    HStack(spacing: 8) {
                        Text("Login")
                        if loading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                    }
                    .padding(.all, 8)
                    .padding(.horizontal, 100)
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink(destination: SignUpView().environmentObject(sessionManager)) {
                    Text("Don't have an account? Sign up.")
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
         }

    }
    
    private func loginButtonTapped() {
        loading = true
        Task {
            await viewModel.login(email: email, password: password) { success, message in
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SharedSessionManager())
    }
}
