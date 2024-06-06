//
//  AuthManager.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 05/06/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    
    var userSession: UserData?
    
    static var shared: AuthManager = {
        return AuthManager()
    }()

    
    func createAccount(email: String, password: String, name: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = UserData(id: result.user.uid, name: name, email: email)
        userSession = user
        let encodedUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
    func login(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        let snapshot = try await Firestore.firestore().collection("users").document(result.user.uid).getDocument()
        userSession = try snapshot.data(as: UserData.self)
    }
    
}
