//
//  SettingsView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel = SettingsViewModel()
    @EnvironmentObject var sessionManager: SharedSessionManager
    
    @State private var showingAlert = false
    @State private var userName = ""
    
    var body: some View {
        NavigationStack {
            List {
                
                Text(viewModel.userName)
                    .alert("Editar nome", isPresented: $showingAlert) {
                        TextField("Your name", text: $userName)
                        Button("OK", action: changeName)
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Atualize o nome que deseja utilizar")
                    }
                    .onTapGesture {
                        showingAlert = true
                    }
                
                Toggle(isOn: $viewModel.isNotificationsEnable) {
                    Text("Notificações")
                }

                Section(header: Text("Idioma")) {
                    Text("🇧🇷 Portugues Brazil")
                    Text("🇺🇸 English")
                }
                
                Button("Logout") {
                    viewModel.logout()
                    sessionManager.isUserSessionActive = false
                }
            }.onAppear() {
                viewModel.setupView()
            }
            .navigationTitle("Configurações")
        }
    }
    
    func changeName() {
        if !userName.isEmpty {
            viewModel.changeName(userName)
            userName = ""
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
