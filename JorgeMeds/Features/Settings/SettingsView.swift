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
                    .alert("Edit Name", isPresented: $showingAlert) {
                        TextField("Your name", text: $userName)
                        Button("OK", action: changeName)
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Update the name you wish to use")
                    }
                    .onTapGesture {
                        showingAlert = true
                    }
                
                Toggle(isOn: $viewModel.isNotificationsEnable) {
                    Text("Notifications")
                }
                .onTapGesture {
                    viewModel.onTapNotification()
                }
                
                Button("Logout") {
                    viewModel.logout()
                    sessionManager.isUserSessionActive = false
                }
            }.onAppear() {
                viewModel.setupView()
            }
            .navigationTitle("Settings")
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
