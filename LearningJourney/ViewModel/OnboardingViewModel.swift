//
//  OnBoardingViewModel.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import Foundation
import SwiftUI
import SwiftData
//extension OnboardingView {
//    @Observable
//    class ViewModel {
//        var goalTitle = ""
//        var duration: learningDuration = .week
//        var isValid = false
//        func validate(){
//            if goalTitle.isEmpty {
//                self.isValid = true
//            }
//        }
//    }
//}



enum Pages : Identifiable, CaseIterable, View{
    case goalPage, calendar
    var id: Self {self}
    var body: some View {
        switch self{
        case .calendar:
            CalendarView()
        case .goalPage:
            ChangeGoalView()
        }
    }
    
}


@Observable
class ViewModel {
    
    // On Boarding VM
    var goalTitle: String = ""
    var goalDuration: learningDuration = .week
    var isValidGoal: Bool = false
    
    func validate() {
         isValidGoal = !goalTitle.isEmpty
     }
    
    func saveUserGoal(context: ModelContext) {
        validate()
        print("Title: '\(goalTitle)'")
        print("Is valid: \(isValidGoal)")
        
        if isValidGoal {
            let goal = Goal(goalTitle, goalDuration)
            context.insert(goal)
            try? context.save()
            print("Goal saved successfully")
        }
    }
    
    func getMaxFreezes(for duration: learningDuration) -> Int {
        switch duration {
        case .week: return 2
        case .month: return 8
        case .year: return 96
        }
    }
    
    // Activity VM
    var isLearned = false
    var isFreezed = false
    var selectedPage: Pages?
    func selectPage(p: Pages){
        self.selectedPage = p
    }
    
    // Changing Goal VM
    var showAlert:Bool = false
    func AlertUser(){
        self.showAlert.toggle()
        
    }
}


// specialized VM of the Badge component
extension Badge {
    @Observable
    class ViewModel {
        var count: Int = 0
        var labelPrefix: String = "Days"
        var label: String = ""
        
        func setView(status: DayStatus, count: Int){
            let labelPrefix = count == 1 ? "Day" : "Days"

            switch status {
            case .Learn:
                label = "\(labelPrefix) Learned"
            case .Freeze:
                label = "\(labelPrefix) Freezed"
                
            }
        }
        
    }
}


extension CalendarPicker {
    @Observable
    class ViewModel {
        var displayedWeek = Date()
        var displayedMonth =  Date()
        
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
        
        var displayedMonth: Date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month],from: Date())) ?? Date()
        
        func GenerateMonth() -> [Date]{
            var months: [Date] = []
            let currentYear = calendar.component(.year, from: Date())
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
