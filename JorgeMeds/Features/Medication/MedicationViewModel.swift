//
//  MedicationViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 06/06/24.
//

import Foundation

class MedicationViewModel: ObservableObject {
    
    let service = MedicationService()
    private let editMedication: Medication?
    
    init(editMedication: Medication? = nil) {
        self.editMedication = editMedication
    }
    
    func saveMedication(name: String, quantity: String, dates: [Date]) {
        if let quantity = Int(quantity) {
            
            if var editMedication {
                editMedication.name = name
                editMedication.hours = parseDates(dates)
                editMedication.quantity = quantity
                
                service.update(medication: editMedication) {
                    print("edited")
                }
                
            } else {
                let medication = Medication(name: name, quantity: quantity, hours: parseDates(dates))
                service.addNewMedication(medication) {
                    print("completition")
                }
            }

        }
    }
    
    private func parseDates(_ dates: [Date]) -> [String] {
        var stringDates = [String]()
        
        for date in dates {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            stringDates.append(formatter.string(from: date))
        }
        
        return stringDates
    }
}
