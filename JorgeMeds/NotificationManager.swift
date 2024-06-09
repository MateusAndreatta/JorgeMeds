//
//  NotificationManager.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 09/06/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    private func checkForPermission(completion: @escaping () -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                completion()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        completion()
                    }
                }
            default:
                return
            }
        }
    }
    
    public func dispatchNotifications(for medicationList: [Medication]) {
        checkForPermission() { [weak self] in
            for medication in medicationList {
                for hour in medication.hours {
                    self?.dispatchNotification(for: medication, at: hour)
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
//        let hour = splitedHours[0]
//        let minute = splitedHours[1]
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
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.add(request)
    }
}
