//
//  NewInformationView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 09/06/24.
//

import SwiftUI

struct NewInformationView: View {
    
    @EnvironmentObject var viewModel: InformationViewModel
    
    @State private var showingAlert = false
    @State private var allergyName = ""
    
    var body: some View {
        List {
            Section(header: Text("Alergias")) {
                if let allergies = viewModel.information?.allergies, allergies.count > 0 {
                    ForEach(0..<allergies.count, id: \.self) { index in
                        Text(allergies[index])
                            .swipeActions {
                                Button("Remove", role: .destructive) {
                                    viewModel.removeAllergy(at: index)
                                }
                                .tint(.red)
                            }
                    }
                }
                Button("Adicionar alergia") {
                    showingAlert.toggle()
                }
                .alert("Nova alergia", isPresented: $showingAlert) {
                    TextField("Alergia", text: $allergyName)
                    Button("OK", action: addAllergy)
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Descreva o nome da alergia para ser adicionada na lista")
                }
            }
        }
        .navigationTitle("Editar informações")
    }
    
    func addAllergy() {
        if !allergyName.isEmpty {
            viewModel.addAllergy(allergyName)
            allergyName = ""
        }
    }
}

struct NewInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NewInformationView()
            .environmentObject(InformationViewModel())
    }
}
