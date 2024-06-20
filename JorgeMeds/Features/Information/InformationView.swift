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
                if viewModel.allergies.count > 0 {
                    Section(header: Text("Allergies")) {
                        ForEach(viewModel.allergies, id: \.self) { allergy in
                            Text(allergy)
                        }
                    }
                }

                if let medications = viewModel.medications, medications.count > 0 {
                    Section(header: Text("Medications in use")) {
                        ForEach(medications) { medication in
                            Text(medication.name)
                        }
                    }
                }
            }
            .navigationTitle("Your information")
            .toolbar {
                let destination = NewInformationView(allergies: viewModel.allergies,
                                                     addAction: { allergy in
                                                        viewModel.addAllergy(allergy)
                                                     },
                                                     removeAction: { index in
                                                        viewModel.removeAllergy(at: index)
                                                     })
                
                NavigationLink(destination: destination) {
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
