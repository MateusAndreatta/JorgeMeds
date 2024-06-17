//
//  HomeViewModel.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 07/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var medicationList = [Medication]()
    
    let service = MedicationService()
    let notificationManager = NotificationManager()
    
    func getMedicationList(completion: @escaping () -> Void) {
        medicationList = []
        service.getAll { [weak self] medications in
            self?.validateTakenMedication(uncheckedMedicationList: medications)
            completion()
        }
    }
    
    func deleteMedication(_ medication: Medication) {
        service.delete(medication: medication) { [weak self] in
            if let index = self?.medicationList.firstIndex(where: {$0.id == medication.id}) {
                self?.medicationList.remove(at: index)
            }
        }
    }
    
    private func validateTakenMedication(uncheckedMedicationList: [Medication]) {
        var medicationToCheck = uncheckedMedicationList
        
        for (index, _) in medicationToCheck.enumerated() {
            let takenMedicine = self.getTakenMedicine(medicationToCheck[index])
            if takenMedicine > 0 {
                medicationToCheck[index].updateQuantity(for: takenMedicine)
                updateMedication(medicationToCheck[index])
            }
            medicationList.append(medicationToCheck[index])
        }
        
        notificationManager.dispatchNotifications(for: medicationList)
    }
    
    private func getTakenMedicine(_ medication: Medication) -> Int {
       guard let lastUpdatedDate = medication.lastUpdate?.dateValue() else { return 0 }
       print(lastUpdatedDate)
       let calendar = Calendar.current
       let currentDate = Date()
       var takenMedicine = 0
       
       if Calendar.current.isDateInToday(lastUpdatedDate) {
           // Ambos sâo a mesma data, verificar apenas as horas:
           print("é o hoje")
           
           for hour in medication.hours {
               let splited = hour.split(separator: ":")

               var dateComponents = DateComponents()

               dateComponents.year = calendar.component(.year, from: currentDate)
               dateComponents.month = calendar.component(.month, from: currentDate)
               dateComponents.day = calendar.component(.day, from: currentDate)
               dateComponents.hour = Int(splited[0])
               dateComponents.minute = Int(splited[1])
               dateComponents.second = calendar.component(.second, from: currentDate)

               if let dateFromHour = calendar.date(from: dateComponents) {
                   if lastUpdatedDate <= dateFromHour && dateFromHour <= Date() {
                       takenMedicine += 1
                   }
               }

           }
           
       } else {
           print("nao é o hoje")
           
           let qtdForDay = medication.hours.count
           
           if let daysBetween = calendar.dateComponents([.day], from: lastUpdatedDate, to: currentDate).day {
               print("daysBetween \(daysBetween)")
               
               let fullDays = daysBetween - 1
               if fullDays > 0 {
                   takenMedicine += fullDays * qtdForDay;
               }
               
               // FirstDay até B 23:59:59 quantos tomou?
               
               var dateComponents = DateComponents()

               dateComponents.year = calendar.component(.year, from: lastUpdatedDate)
               dateComponents.month = calendar.component(.month, from: lastUpdatedDate)
               dateComponents.day = calendar.component(.day, from: lastUpdatedDate)
               dateComponents.hour = 23
               dateComponents.minute = 59
               dateComponents.second = 59

               if let endFirstDay = calendar.date(from: dateComponents) {
                   for hour in medication.hours {
                       let splited = hour.split(separator: ":")
                       
                       var dateComponents = DateComponents()

                       dateComponents.year = calendar.component(.year, from: lastUpdatedDate)
                       dateComponents.month = calendar.component(.month, from: lastUpdatedDate)
                       dateComponents.day = calendar.component(.day, from: lastUpdatedDate)
                       dateComponents.hour = Int(splited[0])
                       dateComponents.minute = Int(splited[1])
                       dateComponents.second = calendar.component(.second, from: lastUpdatedDate)

                       if let dateFromHour = calendar.date(from: dateComponents) {
                           if lastUpdatedDate <= dateFromHour && dateFromHour <= Date() {
                               takenMedicine += 1
                           }
                       }
                   }
               }
               
               // Lastday (currentDate) até 00:00:00 quantos tomou?
               
               dateComponents = DateComponents()

               dateComponents.year = calendar.component(.year, from: currentDate)
               dateComponents.month = calendar.component(.month, from: currentDate)
               dateComponents.day = calendar.component(.day, from: currentDate)
               dateComponents.hour = 0
               dateComponents.minute = 0
               dateComponents.second = 0

               if let endFirstDay = calendar.date(from: dateComponents) {
                   for hour in medication.hours {
                       let splited = hour.split(separator: ":")
                       
                       var dateComponents = DateComponents()

                       dateComponents.year = calendar.component(.year, from: currentDate)
                       dateComponents.month = calendar.component(.month, from: currentDate)
                       dateComponents.day = calendar.component(.day, from: currentDate)
                       dateComponents.hour = Int(splited[0])
                       dateComponents.minute = Int(splited[1])
                       dateComponents.second = calendar.component(.second, from: currentDate)

                       if let dateFromHour = calendar.date(from: dateComponents) {
                           if lastUpdatedDate <= dateFromHour && dateFromHour <= Date() {
                               takenMedicine += 1
                           }
                       }
                   }
               }
           }

           
       }
       
       print("takenMedicine: \(takenMedicine)")
       return takenMedicine
   }
    
    private func updateMedication(_ medication: Medication) {
        service.update(medication: medication, completion: {
            
        })
    }
}
