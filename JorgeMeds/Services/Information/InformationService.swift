//
//  InformationService.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 08/06/24.
//

import Foundation
import FirebaseFirestore

class InformationService {
    
    private var db = Firestore.firestore()
    private let authManager = AuthManager.shared
    
    private let collection = "informacoes"
    
    func addNewInformation(_ information: Information, completion: @escaping () -> Void) {
        guard let userId = authManager.userSession?.id else { return }
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: [
            "allergies": information.allergies,
            "userId" : userId
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion()
            } else {
                completion()
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func update(information: Information, completion: @escaping () -> Void) {
        guard let docId = information.id else { return }
        let ref = db.collection(collection).document(docId)
        
        ref.updateData([
            "allergies": information.allergies
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
            completion()
        }
    }
    
    func getInformation(completion: @escaping (Information?) -> Void) {
        guard let userId = authManager.userSession?.id else { return }
        
        db.collection(collection).whereField("userId", isEqualTo: userId).getDocuments { (querySnapshot, err) in
            guard err == nil else {
                print("error")
                completion(nil)
                return
            }
            
            if let document = querySnapshot?.documents.first {
                let information = try? document.data(as: Information.self)
                completion(information)
                return
            }
            completion(nil)
        }
    }
    
}
