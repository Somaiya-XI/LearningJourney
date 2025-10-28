//
//  SavedDataView.swift
//  LearningJourney
//
//  Created by Somaiya on 01/05/1447 AH.
//

import SwiftUI
import SwiftData
struct SavedDataView: View {
    @State private var dateProvider = DateProvider.shared
    @Environment(\.modelContext) var context
    @Query private var goals: [Goal]
    
    var currentGoal: Goal? {
        goals.first
    }
    
    var days: [Day] {
        currentGoal?.days ?? []
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Total days in DB: \(days.count)").foregroundColor(.red)
                Spacer()
                Button("Delete Goal"){deleteGoal(goal: currentGoal)}
                    .buttonStyle(.glassProminent)
                    .tint(.red.opacity(0.6))
                Spacer()
            }
#if DEBUG
                VStack(spacing: 3) {
                    // Current time display
                    VStack(spacing: 1) {
                        Text(dateProvider.currentDate.formatted(date: .abbreviated, time: .standard))
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    // Quick jumps
                    VStack(spacing: 6) {
                        HStack(spacing: 2) {
                            Button("-1d") { dateProvider.addDays(-1) }
                            Button("+1d") { dateProvider.addDays(1) }
                            Button("+7d") { dateProvider.addDays(7) }
                            Button("+12h") { dateProvider.addHours(12) }
                            Button("+24h") { dateProvider.addHours(24) }
                            Button("+29h") { dateProvider.addHours(29) }                .foregroundStyle(.orange)
                        }
                        HStack{
                            Button("+32h") { dateProvider.addHours(32) }
                                .foregroundStyle(.red)
                            Button("+1h") { dateProvider.addHours(1) }
                                .foregroundStyle(.red)
                            Button("12:00 AM") { dateProvider.addMinutes(1) }
                            Button("11:59 PM") { dateProvider.setToAlmostMidnight() }
                            
                            Button("Reset to Now") {
                                dateProvider.reset()
                                deleteGoal(goal: currentGoal)
                            }
                            .font(.caption)
                            .foregroundStyle(.blue)
                        }
                    }
                    
                    
                }.padding(0)
                    .font(.caption)
                    .buttonStyle(.glass)
#endif
                
            List {
                Section{
                    ForEach(days){ day in
                        Text("\(Calendar.current.component(.day, from: day.date)) day status: \(day.dayStatus.rawValue)")
                    }.onDelete{indecies in
                        for i in indecies{
                            deleteDay(days[i])
                        }
                        
                    }
                }
            }
        }
            
    }
    func deleteGoal(goal: Goal?) {
            if let goal = goal{
                goal.title = ""
                goal.freeze = 0
                goal.streak = 0
                goal.isLoggedToday = false
                goal.isLearned = false
                goal.lastLoggedDay = nil
                goal.days = []
                goal.isGoalAchieved = false
                goal.isMaxFreeze = false
                do {
                    try context.save()

                } catch {
                    print("error resetting")
                }
            }
    }
    
    func deleteDay(_ day: Day){
        context.delete(day)
    }
}

#Preview {
    SavedDataView()
}

