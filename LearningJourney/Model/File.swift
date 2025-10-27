//
//  File.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import Foundation
import SwiftData

enum learningDuration: String, Identifiable, CaseIterable, Codable {
    case week = "Week"
    case month = "Month"
    case year = "Year"
    var id: Self { self }
}

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

enum DayStatus: String, Codable {
    case Learn = "Learn"
    case Freeze = "Freeze"
}

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

