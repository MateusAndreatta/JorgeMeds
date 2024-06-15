//
//  SettingsViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 12/06/24.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    let authManager = AuthManager.shared
    let notificationManager = NotificationManager()
    let defaults = UserDefaults.standard
    
    @Published var userName = ""
    @Published var isNotificationsEnable = false {
        didSet {
            print("myVar changed! \(isNotificationsEnable)")
            defaults.set(isNotificationsEnable, forKey: "isNotificationsEnable")
            setupNotification()
        }
    }
    
    func logout() {
        authManager.userSession = nil
    }

    func setupView() {
        isNotificationsEnable = defaults.bool(forKey: "isNotificationsEnable")
        userName = authManager.userSession?.name ?? "Tap to setup your name"
    }
    
    func setupNotification() {
        if isNotificationsEnable {
            Task {
                notificationManager.requestAuthorization { [weak self] didAllow in
                    DispatchQueue.main.async {
                        self?.isNotificationsEnable = didAllow
                    }
                }
            }
        }
    }
    
    func changeName(_ name: String) {
        userName = name
        authManager.changeUserName(name)
    }
    
}
