//
//  HomeView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.medicationList) { medication in
                    MedicationItem(medication: medication)
                        .onTapGesture {
                            print("edit")
                        }
                        .onLongPressGesture {
                            viewModel.deleteMedication(medication)
                        }
                        .listRowSeparator(.hidden)
                }
                
                ZStack {
                  Text("Novo medicamento")
                  NavigationLink(destination: MedicationView(), label: {
                      EmptyView()
                  }).opacity(0)
                }
                .listRowSeparator(.hidden)

            }
            .listStyle(.plain)
            .navigationTitle("Medicamentos")
        }.onAppear() {
            viewModel.getMedicationList()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
