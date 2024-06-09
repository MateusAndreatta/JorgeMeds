//
//  Medication.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 07/06/24.
//

import Foundation
import FirebaseFirestore

struct Medication: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var quantity: Int
    var hours: [String]
}

extension Medication {
    var dateHours: [Date] {
        var dates = [Date]()
        let calendar = Calendar.current
        let currentDate = Date()
        
        for hour in hours {
            let splited = hour.split(separator: ":")

            var dateComponents = DateComponents()

            dateComponents.year = calendar.component(.year, from: currentDate)
            dateComponents.month = calendar.component(.month, from: currentDate)
            dateComponents.day = calendar.component(.day, from: currentDate)
            dateComponents.hour = Int(splited[0])
            dateComponents.minute = Int(splited[1])
            dateComponents.second = calendar.component(.second, from: currentDate)

            if let dateFromHour = calendar.date(from: dateComponents) {
                dates.append(dateFromHour)
            }
        }
        
        return dates
    }
}
