//
//  SignUpViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    
    let authManager = AuthManager.shared
    
    func createAccount(name: String, email: String, password: String, confirmPassword: String, completion: @escaping (Bool, String) -> Void) async {
        if validateRequiredFields(name: name, email: email, password: password, confirmPassword: confirmPassword) {
            if validatePassword(password: password, confirmPassword: confirmPassword) {
                do {
                    try await authManager.createAccount(email: email, password: password, name: name)
                    completion(true, "")
                } catch {
                    completion(false, "Unable to create user account, try again later")
                }
            } else {
                completion(false, "passwords not valid")
            }
        } else {
            completion(false, "Required fields missing")
        }
    }
    
    private func validateRequiredFields(name: String, email: String, password: String, confirmPassword: String) -> Bool {
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            return false
        }
        return true
    }
    
    private func validatePassword(password: String, confirmPassword: String) -> Bool {
        guard password == confirmPassword else { return false }
        if password.isEmpty || confirmPassword.isEmpty {
            return false
        }
        return true
    }
    
}
