//
//  MedicationView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 06/06/24.
//

import SwiftUI

struct MedicationView: View {
    @ObservedObject var viewModel: MedicationViewModel
    let editMedication: Medication?
    
    @State var name: String
    @State var quantity: String
    @State var dates: [Date]
    
    init(editMedication: Medication?) {
        self.editMedication = editMedication
        if let editMedication {
            self.viewModel = MedicationViewModel(editMedication: editMedication)
            
            name = editMedication.name
            quantity = String(editMedication.quantity)
            dates = editMedication.dateHours
        } else {
            self.viewModel = MedicationViewModel(editMedication: nil)
            name = ""
            quantity = ""
            dates = []
        }
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
                TextField("Quantity of pills", text: $quantity)
                    .keyboardType(.numberPad)
                
                ForEach(0..<$dates.count, id: \.self) { index in
                    DatePicker("Time", selection: $dates[index], displayedComponents: .hourAndMinute)
                        .swipeActions {
                            Button("Remove", role: .destructive) {
                                dates.remove(at: index)
                            }
                            .tint(.red)
                        }
                }

                Button("Add time") {
                    dates.append(Date())
                }
                
            }
            
            Button {
                viewModel.saveMedication(name: name, quantity: quantity, dates: dates)
            } label: {
                Text("Save")
                    .padding(.all, 8)
                    .padding(.horizontal, 100)
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationBarTitle("Medication")
    }
}

struct MedicationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MedicationView(editMedication: nil)
        }
    }
}
