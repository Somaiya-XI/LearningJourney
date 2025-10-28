//
//  ViewModel.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import Foundation
import SwiftUI
import SwiftData

// Enum that contains navigation data to loop and view pages based on user action -> click to navigate
enum Pages : Identifiable, CaseIterable, View {
    case goalPage
    case calendar
//    case test
    var id: Self {self}
    var body: some View {
        switch self{
        case .calendar:
            CalendarView()
        case .goalPage:
            ChangeGoalView()
//        case .test:
//            SavedDataView()
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
        
        // context aware to load the goal on views
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
        
        // Getting the number of days required to achieve the goal
        func getGoalDurationInDays(for duration: learningDuration) -> Int {
            switch duration {
            case .week: return 7
            case .month: return 30
            case .year: return 365
            }
        }
        
        // Activity VM
        var selectedPage: Pages?
        func selectPage(p: Pages){
            self.selectedPage = p
        }
        
        // Changing Goal VM
        var showAlert:Bool = false
        
        func AlertUser(){
            self.showAlert.toggle()
        }
        
        // Updating all goal values and setting the new title/duration
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
                goal.isGoalAchieved = false
                goal.isMaxFreeze = false
                try? context.save()
            }
        }
        
        // Resetting the goal values while keeping the setted title and duration
        func resetGoal(goal: Goal? ,_ context: ModelContext){
            if let goal = goal {
                goal.streak = 0
                goal.freeze = 0
                goal.lastLoggedDay = nil
                goal.isLoggedToday = false
                goal.isLearned = false
                goal.days = []
                goal.isMaxFreeze = false
                goal.isGoalAchieved = false
                try? context.save()
            }
        }
        
        // Freezing the day and saving the data to the local storage
        func logAsFreezed(goal: Goal? ,_ context: ModelContext){
            if let goal = goal {
                
                goal.isLearned = false
                goal.isLoggedToday = true
                goal.freeze += 1
                let day = Day(date: DateProvider.shared.now(), dayStatus: .Freeze)
                goal.days.append(day)
                goal.lastLoggedDay = day
                try? context.save()
                
                if (goal.streak + goal.freeze) == getGoalDurationInDays(for: goal.learningDuration){
                    goal.isGoalAchieved = true
                }
                
                if getMaxFreezes(for: goal.learningDuration) == goal.freeze {
                    goal.isMaxFreeze = true
                }
                
            }
        }
        
        // Logging learned day and saving the data to the local storage
        func logAsLearned(goal: Goal? ,_ context: ModelContext){
            if let goal = goal {
                goal.isLearned = true
                goal.isLoggedToday = true
                
                goal.streak += 1
                let day = Day(date: DateProvider.shared.now(), dayStatus: .Learn)
                goal.days.append(day)
                goal.lastLoggedDay = day
                
                if (goal.streak + goal.freeze) == getGoalDurationInDays(for: goal.learningDuration){
                    goal.isGoalAchieved = true
                }
                try? context.save()
            }
        }
        
        // Reset function to check if nex day has came or if the user did not log for +32h
        func checkAndResetIfNewDay(goal: Goal?, context: ModelContext) {
            guard let goal = goal else { return }
            
            if let lastLoggedDate = goal.lastLoggedDay?.date {
                
                let calendar = Calendar.current
                let now = DateProvider.shared.now()
                let today = calendar.startOfDay(for: now)
                let lastLogged = calendar.startOfDay(for: lastLoggedDate)
                
                let timeInterval = now.timeIntervalSince(lastLoggedDate)
                let hoursPassed = timeInterval / 3600
                
                /*
                 if the current day is greater than the
                 last day logged reset the current day logs
                 */
                if today > lastLogged {
                    
                    goal.isLoggedToday = false
                    goal.isLearned = false
                    
                    
                    /*
                     if the current day is greater than the
                     last day logged and then 32h already passed
                     from the last log then reset all goal values
                     */
                    if hoursPassed >= 32 {
                        resetGoal(goal: goal, context)
                        print("Streak reset - 32+ hours passed (logged at \(lastLoggedDate), now is \(now))")
                    }
                    
                    // Save changes
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
    
    
    



