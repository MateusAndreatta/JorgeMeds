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
    
    @Published var information: Information?
    @Published var medications: [Medication]?
    
    func fetchInformation() {
        service.getInformation { [weak self] information in
            if let information {
                self?.information = information
            }
        }
        
        medicationService.getAll { [weak self] medicationList in
            self?.medications = medicationList
        }
    }
    
    func removeAllergy(at index: Int) {
        if var information {
            information.allergies.remove(at: index)
            service.update(information: information) {
                
            }
        }
    }
    
    func addAllergy(_ allergy: String) {
        if var information {
            information.allergies.append(allergy)
            service.update(information: information) {
                
            }
        } else {
            let newInformation = Information(allergies: [allergy])
            service.addNewInformation(newInformation, completion: { [weak self] in
                self?.fetchInformation()
            })
        }
    }
    
}
