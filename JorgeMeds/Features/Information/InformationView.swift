//
//  InformationView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct InformationView: View {
    
    @ObservedObject var viewModel = InformationViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if let allergies = viewModel.information?.allergies, allergies.count > 0 {
                    Section(header: Text("Alergias")) {
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
                }
                
                Section(header: Text("Medicamentos em uso")) {
                    Text("Bromoprida")
                    Text("Tramal")
                    Text("Nimesulina")
                    Text("Plasil")
                    Text("Amoxilina")
                    Text("Digesam")
                }
            }
            .navigationTitle("Seus dados")
        }
        .onAppear() {
            viewModel.fetchInformation()
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
