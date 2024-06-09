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
                        }
                    }
                }
                
                if let medications = viewModel.medications, medications.count > 0 {
                    Section(header: Text("Medicamentos em uso")) {
                        ForEach(medications) { medication in
                            Text(medication.name)
                        }
                    }
                }
            }
            .navigationTitle("Seus dados")
            .toolbar {
                NavigationLink(destination: NewInformationView().environmentObject(viewModel)) {
                    Image(systemName: "plus").foregroundColor(.gray)
                }
            }
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
