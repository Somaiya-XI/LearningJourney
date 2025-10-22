//
//  File.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import Foundation



enum learningDuration { case week, month, year }

class Goal{
    var title: String
    var learningDuration: learningDuration
    var streak: Int = 0
    var freez: Int
    
    init(_ title: String, _ learningDuration: learningDuration) {
        self.title = title
        self.learningDuration = learningDuration
        self.streak = 0
        switch learningDuration {
        case .week:
            self.freez = 2
        case .month:
            self.freez = 8
        case.year:
            self.freez = 96
        }
    }
    
}
