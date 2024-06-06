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
            try await authManager.login(email: email, password: password)
            completion(true, "")
        } catch {
            completion(false, "Unable to login, try again later...")
        }
    }
    
}

