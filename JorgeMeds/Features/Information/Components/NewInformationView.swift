//
//  NewInformationView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 09/06/24.
//

import SwiftUI

struct NewInformationView: View {
    
    var allergies: [String]
    var addAction: (String) -> Void
    var removeAction: (Int) -> Void
    
    @State private var showingAlert = false
    @State private var allergyName = ""
    
    var body: some View {
        List {
            Section(header: Text("Allergies")) {
                    ForEach(0..<allergies.count, id: \.self) { index in
                        Text(allergies[index])
                            .swipeActions {
                                Button("Remove", role: .destructive) {
                                    removeAction(index)
                                }
                                .tint(.red)
                            }
                    }
                Button("Add Allergy") {
                    showingAlert.toggle()
                }
                .alert("New Allergy", isPresented: $showingAlert) {
                    TextField("Allergy", text: $allergyName)
                    Button("OK", action: addAllergy)
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Describe the name of the allergy to be added to the list")
                }
            }
        }
        .navigationTitle("Edit Information")
    }
    
    func addAllergy() {
        if !allergyName.isEmpty {
            addAction(allergyName)
            allergyName = ""
        }
    }
}

struct NewInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NewInformationView(allergies: ["Nimesulina"], addAction: {_ in }, removeAction: {_ in })
    }
}
