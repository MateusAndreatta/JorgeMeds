//
//  HomeViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 07/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var medicationList = [Medication]()
    
    let service = MedicationService()
    
    func getMedicationList() {
        service.getAll { [weak self] medications in
            self?.medicationList = medications
        }
    }
    
    func deleteMedication(_ medication: Medication) {
        service.delete(medication: medication) { [weak self] in
            if let index = self?.medicationList.firstIndex(where: {$0.id == medication.id}) {
                self?.medicationList.remove(at: index)
            }
        }
    }
}
