//
//  TestDifferentDate.swift
//  LearningJourney
//
//  Created by Somaiya on 06/05/1447 AH.
//

import Foundation

@Observable
class DateProvider {
    static let shared = DateProvider()
    
    var currentDate = Date()
    
    func now() -> Date {
        return currentDate
    }
    
    // Testing helpers
    func addDays(_ days: Int) {
        currentDate = Calendar.current.date(byAdding: .day, value: days, to: currentDate) ?? currentDate
    }
    
    func addHours(_ hours: Int) {
        currentDate = Calendar.current.date(byAdding: .hour, value: hours, to: currentDate) ?? currentDate
    }
    
    func addMinutes(_ minutes: Int) {
        currentDate = Calendar.current.date(byAdding: .minute, value: minutes, to: currentDate) ?? currentDate
    }
    
    func setToMidnight() {
        let calendar = Calendar.current
        currentDate = calendar.startOfDay(for: currentDate)
    }
    
    func setToAlmostMidnight() {
        let calendar = Calendar.current
        if let midnight = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: currentDate) {
            currentDate = midnight
        }
    }
    
    func reset() {
        currentDate = Date()
    }
}
