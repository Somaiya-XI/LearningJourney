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
    
    func reset() {
        currentDate = Date()
    }
}
