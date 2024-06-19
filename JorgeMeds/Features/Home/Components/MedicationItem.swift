//
//  MedicationItem.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 07/06/24.
//

import SwiftUI

struct MedicationItem: View {
    
    var medication: Medication
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(medication.name).font(.headline).padding(.bottom, 8)
                Text("💊 \(medication.quantity) pills remaining")
                if medication.hours.count > 0 {
                    Text("🗓️ It will run out on \(calculateEndingDate())")
                }
            }.padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
    
    func calculateEndingDate() -> String {
        let qtdForDay = medication.hours.count
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = medication.quantity / qtdForDay

        if let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate) {
            return "\(futureDate.formatted(.dateTime.day(.twoDigits)))/\(futureDate.formatted(.dateTime.month(.twoDigits))) "
        }
        return " - / -"
    }
}

struct MedicationItem_Previews: PreviewProvider {
    static var previews: some View {
        MedicationItem(medication: Medication(name: "Topiramato", quantity: 5, hours: [""]))
    }
}
