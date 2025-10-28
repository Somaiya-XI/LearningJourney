//
//  CalendarView.ViewModel.swift
//  LearningJourney
//
//  Created by Somaiya on 06/05/1447 AH.
//

import Foundation
import SwiftUI


extension CalendarView {
    @Observable
    class ViewModel {
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
        
        var displayedMonth: Date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month],from: DateProvider.shared.now())) ?? Date()
        
        func GenerateMonth() -> [Date]{
            var months: [Date] = []
            let currentYear = calendar.component(.year, from: DateProvider.shared.now())
            for month in 1...39 {
                if let date = calendar.date(from: DateComponents(year: currentYear, month: month)){
                    months.append(date)
                }
            }
            return months
        }
        
        func GenerateMonthGrid(for month: Date) -> [Date]{
            guard let monthInterval = calendar.dateInterval(of: .month, for: month),
                  let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                  let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1 )
            else {return []}
            return stride(from: firstWeek.start,
                          to: lastWeek.end, by: 86400).map {$0}
        }
        
        
    }
}
