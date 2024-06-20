//
//  LoginViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    let authManager = AuthManager.shared
    
    func login(email: String, password: String, completion: @escaping (Bool, String) -> Void) async {
        do {
            if validateRequiredFields(email: email, password: password) {
                try await authManager.login(email: "mateus@gmail.com", password: "123123")
//                try await authManager.login(email: email, password: password)
                completion(true, "")
            } else {
                completion(false, "Required fields missing")
            }
        } catch {
            completion(false, "Unable to login, try again later...")
        }
    }
    
    private func validateRequiredFields(email: String, password: String) -> Bool {
        if email.isEmpty || password.isEmpty {
            return false
        }
        return true
    }
    
}

