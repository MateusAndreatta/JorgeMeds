//
//  NotificationManager.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 09/06/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    let defaults = UserDefaults.standard
    
    public func checkForPermission(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { [weak self] settings in
            switch settings.authorizationStatus {
            case .authorized:
                completion(true)
            case .denied:
                completion(false)
            case .notDetermined:
                self?.requestAuthorization() { didAllow in
                    completion(didAllow)
                }
            default:
                completion(false)
            }
        }
    }
    
    public func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
            completion(didAllow)
        }
    }
    
    public func dispatchNotifications(for medicationList: [Medication]) {
        let isNotificationsEnable = defaults.bool(forKey: "isNotificationsEnable")
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        if isNotificationsEnable {
            checkForPermission() { [weak self] isEnable in
                if isEnable {
                    for medication in medicationList {
                        for hour in medication.hours {
                            self?.dispatchNotification(for: medication, at: hour)
                        }
                    }
                }
            }
        }
    }
    
    private func dispatchNotification(for medication: Medication, at hours: String) {
        let splitedHours = hours.split(separator: ":")
        guard let hour = Int(splitedHours[0]), let minute = Int(splitedHours[1]) else { return }
        
        let identifier = "identifier-\(medication.name)-\(hour)-\(minute)"
        let title = "Time to take \(medication.name)"
        let body = "Don't forget to take \(medication.name)!"
        let isDaily = true
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = Int(hour)
        dateComponents.minute = Int(minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
}
