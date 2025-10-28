//
//  CalendarPicker.ViewModel.swift
//  LearningJourney
//
//  Created by Somaiya on 06/05/1447 AH.
//

import Foundation
import SwiftUI


extension CalendarPicker {
    @Observable
    class ViewModel {
        var isWeelView = false
        var displayedWeek = DateProvider.shared.now()
        var displayedMonth =  DateProvider.shared.now()
        
        let calendar = Calendar.current
        
        let formatter: DateFormatter =
        {
            let f = DateFormatter()
            f.dateFormat = "MMMM YYYY"
            return f
        }()
        
        var weekdays: [String] {
            let days = self.calendar.shortWeekdaySymbols
            return Array(days)
        }
        
        func ChangeWeek(by value: Int){
            displayedWeek = self.calendar.date(byAdding: .weekOfMonth, value: value, to: self.displayedWeek) ?? self.displayedWeek
        }
        
        func ChangeMonth(by value: Int){
            displayedMonth = self.calendar.date(byAdding: .weekOfMonth, value: value, to: self.displayedMonth) ?? self.displayedMonth
        }
        
        func GenerateWeekGrid() -> [Date]{
            guard let weekInterval = self.calendar.dateInterval(of: .weekOfMonth, for: self.displayedWeek),
                  let startOfWeek = self.calendar.dateInterval(of: .day, for: weekInterval.start),
                  let endOfWeek = self.calendar.dateInterval(of: .day, for: weekInterval.end - 1)
            else {return []}
            return stride(from: startOfWeek.start,
                          to: endOfWeek.end, by: 86400).map {$0}
        }
    }
}
