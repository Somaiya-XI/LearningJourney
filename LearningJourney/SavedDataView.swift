//
//  SavedDataView.swift
//  LearningJourney
//
//  Created by Somaiya on 01/05/1447 AH.
//

import SwiftUI
import SwiftData
struct SavedDataView: View {
    
    @Environment(\.modelContext) var context
    @Query private var days: [Day]
    @Query private var goals: [Goal]

    var body: some View {
        VStack{
            Text("Total days in DB: \(days.count)") // DEBUG
                            .foregroundColor(.red)
            HStack{
                Button("Learn a day"){
                    let day = Day(date: Date(), dayStatus: .Learn)
                    context.insert(day)
                }.buttonStyle(.glassProminent)
                    .tint(.accentPrimaryExact)
                
                Button("Freez a day"){
                    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
                    
                    let day = Day(date: yesterday, dayStatus: .Freeze)
                    context.insert(day)
                }.buttonStyle(.glassProminent)
                    .tint(.accentSecondary)
                
                Button("Delete"){
                    deleteAllDays()
                }.buttonStyle(.glassProminent)
                    .tint(.red.opacity(0.9))
            }
            
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
                Section{
                    ForEach(goals){ goal in
                        Text("\(goal.title) ")
                    }
                }
            }
        }
            
    }
    func deleteAllDays() {
        do {
            try context.delete(model: Goal.self)

            try context.save()
        } catch {
            print("Failed to delete all days: \(error)")
        }
    }
    
    func deleteDay(_ day: Day){
        context.delete(day)
    }
}

#Preview {
    SavedDataView()
}

