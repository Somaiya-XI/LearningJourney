//
//  File.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import Foundation
import SwiftData

// enum to provide all the duration choices
enum learningDuration: String, Identifiable, CaseIterable, Codable {
    case week = "Week"
    case month = "Month"
    case year = "Year"
    var id: Self { self }
}

// enum to provide the status of logged days
enum DayStatus: String, Codable {
    case Learn = "Learn"
    case Freeze = "Freeze"
}

// Model to store the day date and status
@Model
class Day: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var dayStatus: DayStatus
    
    init(date: Date, dayStatus: DayStatus) {
        self.id = UUID()
        self.date = date
        self.dayStatus = dayStatus
    }
}

// Model to store the goal with its related days list and current goal progress
@Model
class Goal: Identifiable {
    var id: UUID = UUID()
    var title: String
    var learningDuration: learningDuration
    var streak: Int = 0
    var freeze: Int = 0
    var lastLoggedDay: Day?
    var isLoggedToday: Bool
    var isLearned: Bool
    var days: [Day] = []
    var isGoalAchieved: Bool = false
    var isMaxFreeze = false
    
    init(_ title: String, _ learningDuration: learningDuration, _ lastLoggedDay: Day? = nil) {
        self.id = UUID()
        self.title = title
        self.learningDuration = learningDuration
        self.streak = 0
        self.freeze = 0
        self.lastLoggedDay = lastLoggedDay
        self.isLoggedToday = false
        self.isLearned = false

    }
    
}



