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
    private var currentGoal: Goal?
    private var modelContext: ModelContext?

    // On Boarding VM
    var goalTitle: String = ""
    var goalDuration: learningDuration = .week
    var isValidGoal: Bool = false
    
    
    // Load existing goal from context and sync states
    private func loadCurrentGoal() {
        guard let modelContext = modelContext else { return }
        
        do {
            let goals = try modelContext.fetch(FetchDescriptor<Goal>())
            if let goal = goals.first {
                currentGoal = goal
                goalTitle = goal.title
                goalDuration = goal.learningDuration
            }
        } catch {
            print("Failed to fetch goal: \(error)")
        }
    }
    
    func loadGoal(context: ModelContext) {
        self.modelContext = context
        loadCurrentGoal()
    }
    
    
    // Validating the user goal
    func validate() {
         isValidGoal = !goalTitle.isEmpty
     }
    
    // Save the user goal after the validation
    func saveUserGoal(context: ModelContext) {
            validate()
            
            if isValidGoal {
                let goal = Goal(goalTitle, goalDuration)
                context.insert(goal)
                
                do {
                    try context.save()
                    print("Goal saved successfully: \(goal.title)")
                } catch {
                    print("Failed to save goal: \(error)")
                    isValidGoal = false
                }
            }
        }
    
    // Getting the maximum allowed freeze based on the selected learning duration
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
    var isMaxFreeze = false
    
    var selectedPage: Pages?
    func selectPage(p: Pages){
        self.selectedPage = p
    }
    
    // Changing Goal VM
    var showAlert:Bool = false
    func AlertUser(){
        self.showAlert.toggle()
    }
    
    func updateGoal(goal: Goal? ,_ context: ModelContext){
        if let goal = goal {
            goal.title = goalTitle
            goal.learningDuration = goalDuration
            goal.streak = 0
            goal.freeze = 0
            goal.lastLoggedDay = nil
            goal.isLoggedToday = false
            goal.isLearned = false
            goal.days = []
            try? context.save()
        }
    }
    
    func resetGoal(goal: Goal? ,_ context: ModelContext){
        if let goal = goal {
            goal.streak = 0
            goal.freeze = 0
            goal.lastLoggedDay = nil
            goal.isLoggedToday = false
            goal.isLearned = false
            goal.days = []
            try? context.save()
        }
    }
    
    func logAsFreezed(goal: Goal? ,_ context: ModelContext){
        if let goal = goal {
            if getMaxFreezes(for: goal.learningDuration) != goal.freeze {
                goal.isLearned = false
                goal.isLoggedToday = true
                goal.freeze += 1
                let day = Day(date: Date(), dayStatus: .Freeze)
                goal.days.append(day)
                goal.lastLoggedDay = day
                try? context.save()
            } else {
                isMaxFreeze = true
            }
            
        }
    }
    
    func logAsLearned(goal: Goal? ,_ context: ModelContext){
        if let goal = goal {
            goal.isLearned = true
            goal.isLoggedToday = true

            goal.streak += 1
            let day = Day(date: Date(), dayStatus: .Learn)
            goal.days.append(day)
            goal.lastLoggedDay = day
            try? context.save()
        }
    }
    
    func checkAndResetIfNewDay(goal: Goal?, context: ModelContext) {
        guard let goal = goal else { return }
        
        if let lastLoggedDate = goal.lastLoggedDay?.date {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let lastLogged = calendar.startOfDay(for: lastLoggedDate)
            let now = Date()
            
            let timeInterval = now.timeIntervalSince(lastLoggedDate)
               let hoursPassed = timeInterval / 3600 
            // If it's a new day
            if today > lastLogged {

                goal.isLoggedToday = false
                goal.isLearned = false

                
                // Check if they missed 32 hours streak resets
                if hoursPassed >= 32 {
                    resetGoal(goal: goal, context)
                    print("Streak reset - 32+ hours passed (logged at \(lastLoggedDate), now is \(now))")
                }
                
                do {
                    try context.save()
                    print("Daily status reset for new day")
                } catch {
                    print("Failed to save reset: \(error)")
                }
            }
        }
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
