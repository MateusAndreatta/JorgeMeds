//
//  SettingsViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 12/06/24.
//

import Foundation
import UIKit

class SettingsViewModel: ObservableObject {
    
    let authManager = AuthManager.shared
    let notificationManager = NotificationManager()
    let defaults = UserDefaults.standard
    
    @Published var userName = ""
    @Published var isNotificationsEnable = false {
        didSet {
            defaults.set(isNotificationsEnable, forKey: "isNotificationsEnable")
        }
    }
    
    func logout() {
        authManager.userSession = nil
    }

    func setupView() {
        isNotificationsEnable = defaults.bool(forKey: "isNotificationsEnable")
        userName = authManager.userSession?.name ?? "Tap to setup your name"
    }

    func onTapNotification() {
        if !isNotificationsEnable {
            openAppSettings()
        }
    }
    
    private func openAppSettings() {
         guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
             return
         }
         if UIApplication.shared.canOpenURL(settingsUrl) {
             UIApplication.shared.open(settingsUrl, completionHandler: { success in
                 print("open app settings: \(success)")
             })
         }
     }
    
    func changeName(_ name: String) {
        userName = name
        authManager.changeUserName(name)
    }
    
}
