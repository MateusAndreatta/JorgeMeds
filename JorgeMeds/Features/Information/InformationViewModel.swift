//
//  InformationViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 08/06/24.
//

import Foundation

class InformationViewModel: ObservableObject {
    
    let service = InformationService()
    
    @Published var information: Information?
    
    func fetchInformation() {
        service.getInformation { [weak self] information in
            if let information {
                self?.information = information
            }
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
//        if var information {
//            information.allergies.remove(at: index)
//            service.update(information: information) {
//                
//            }
//        }
    }
    
}
