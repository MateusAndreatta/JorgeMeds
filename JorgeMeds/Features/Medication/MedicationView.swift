//
//  MedicationView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 06/06/24.
//

import SwiftUI

struct MedicationView: View {
    @ObservedObject var viewModel = MedicationViewModel()
    let editMedication: Medication? = nil
    
    @State var name: String = ""
    @State var quantity: String = ""
    @State var dates: [Date] = [Date()]
    
//    init(editMedication: Medication? = nil) {
//        if let editMedication {
//            name = editMedication.name
//            quantity = String(editMedication.quantity)
//            dates = editMedication.dateHours
//            viewModel = MedicationViewModel(editMedication: editMedication)
//            self.editMedication = editMedication
//        }
//    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Nome", text: $name)
                TextField("Quantidade", text: $quantity)
                    .keyboardType(.numberPad)
                
                ForEach(0..<$dates.count, id: \.self) { index in
                    DatePicker("Horário", selection: $dates[index], displayedComponents: .hourAndMinute)
                        .swipeActions {
                            Button("Remove", role: .destructive) {
                                dates.remove(at: index)
                            }
                            .tint(.red)
                        }
                }

                Button("Adicionar horário") {
                    dates.append(Date())
                }
                
            }
            Button("Salvar") {
                viewModel.saveMedication(name: name, quantity: quantity, dates: dates)
            }
        }
        .navigationBarTitle("Medicamento")
    }
}

struct MedicationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MedicationView()
        }
    }
}
