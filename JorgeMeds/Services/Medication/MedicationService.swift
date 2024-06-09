//
//  MedicationService.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 07/06/24.
//

import Foundation
import FirebaseFirestore

class MedicationService {
    
    private var db = Firestore.firestore()
    private let authManager = AuthManager.shared
    
    private let collection = "medications"
    
    func addNewMedication(_ medication: Medication, completion: @escaping () -> Void) {
        guard let userId = authManager.userSession?.id else { return }
        
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: [
            "name": medication.name,
            "quantity": medication.quantity,
            "hours": medication.hours,
            "lastUpdate": FieldValue.serverTimestamp(),
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
    
    func update(medication: Medication, completion: @escaping () -> Void) {
        guard let docId = medication.id else { return }
        let ref = db.collection(collection).document(docId)
        
        ref.updateData([
            "name": medication.name,
            "quantity": medication.quantity,
            "hours": medication.hours,
            "lastUpdate": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
            completion()
        }
    }
    
    func delete(medication: Medication, completion: @escaping () -> Void) {
        guard let docId = medication.id else { return }
        let medicineRef = db.collection(collection).document(docId)
        
        medicineRef.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
            completion()
        }
    }
    
    func getAll(completion: @escaping ([Medication]) -> Void) {
        guard let userId = authManager.userSession?.id else { return }

        db.collection(collection).whereField("userId", isEqualTo: userId).getDocuments { (querySnapshot, err) in
            guard err == nil else {
                print("error")
                completion([])
                return
            }
            var medicationList: [Medication] = []
            if let documents = querySnapshot?.documents {
                for document in documents {
                    if let medication = try? document.data(as: Medication.self) {
                        medicationList.append(medication)
                    }
                }
            }
            completion(medicationList)
        }
    }
    
}
