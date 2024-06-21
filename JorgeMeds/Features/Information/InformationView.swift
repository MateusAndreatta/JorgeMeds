//
//  InformationView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct InformationView: View {
    
    @ObservedObject var viewModel = InformationViewModel()
    
    @State private var showingAlert: Bool = false
    
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
                                                        viewModel.addAllergy(allergy, completion: showErrorAlert)
                                                     },
                                                     removeAction: { index in
                                                        viewModel.removeAllergy(at: index, completion: showErrorAlert)
                                                     })
                NavigationLink(destination: destination) {
                    Image(systemName: "plus").foregroundColor(.gray)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error!"), message: Text("Please try again later"), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear() {
            viewModel.fetchInformation()
        }
    }
    
    private func showErrorAlert(_ success: Bool) {
        showingAlert = !success
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
