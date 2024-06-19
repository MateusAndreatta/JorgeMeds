//
//  InformationViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 08/06/24.
//

import Foundation

class InformationViewModel: ObservableObject {
    
    let service = InformationService()
    let medicationService = MedicationService()
    
    private var information: Information?
    
    @Published var medications: [Medication]?
    @Published var allergies: [String] = []
    
    func fetchInformation() {
        service.getInformation { [weak self] information in
            if let information {
                self?.information = information
                self?.allergies = information.allergies
            }
        }
        
        medicationService.getAll { [weak self] medicationList in
            self?.medications = medicationList
        }
    }
    
    func removeAllergy(at index: Int) {
        if var information {
            information.allergies.remove(at: index)
            allergies = information.allergies
            service.update(information: information) {
                
            }
        }
    }
    
    func addAllergy(_ allergy: String) {
        if var information {
            information.allergies.append(allergy)
            allergies = information.allergies
            service.update(information: information) {
                
            }
        } else {
            let newInformation = Information(allergies: [allergy])
            allergies = newInformation.allergies
            service.addNewInformation(newInformation, completion: { [weak self] in
                self?.fetchInformation()
            })
        }
    }
    
}
