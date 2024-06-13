//
//  ContentView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

class SharedSessionManager: ObservableObject {
    @Published var isUserSessionActive = false
}

struct ContentView: View {
    
    @StateObject var sessionManager = SharedSessionManager()
    
    var body: some View {
        if sessionManager.isUserSessionActive {
            content
        } else {
            LoginView()
                .environmentObject(sessionManager)
        }
    }
    
    var content: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("", systemImage: "house")
                }

            InformationView()
                .tabItem {
                    Label("", systemImage: "info.square")
                }
            
            SettingsView()
                .environmentObject(sessionManager)
                .tabItem {
                    Label("", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
