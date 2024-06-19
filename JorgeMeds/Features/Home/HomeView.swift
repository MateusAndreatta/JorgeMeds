//
//  HomeView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var selectedMedication: Medication?
    @State private var isMedicationViewActive: Bool = false
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            Group {
                
                if isLoading {
                    ProgressView()
                } else {
                    contentView()
                }

            }
            .navigationTitle("Medications")
            .navigationDestination(isPresented: $isMedicationViewActive) {
                if let medication = selectedMedication {
                    MedicationView(editMedication: medication, forceReloadingAction: reload)
                }
            }
        }.onAppear() {
            isLoading = true
            viewModel.getMedicationList {
                isLoading = false
            }
        }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        List {
            ForEach(viewModel.medicationList) { medication in
                MedicationItem(medication: medication)
                    .onTapGesture {
                        selectedMedication = medication
                        isMedicationViewActive = true
                    }
                    .onLongPressGesture {
                        viewModel.deleteMedication(medication)
                    }
                    .listRowSeparator(.hidden)
            }
            
            ZStack {
              Text("New medication")
              NavigationLink(destination: MedicationView(editMedication: nil, forceReloadingAction: reload), label: {
                  EmptyView()
              }).opacity(0)
            }
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
    }
    
    private func reload() {
        isLoading = true
        viewModel.getMedicationList {
            isLoading = false
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
