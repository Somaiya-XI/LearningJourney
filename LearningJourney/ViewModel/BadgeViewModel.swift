//
//  Badge.swift
//  LearningJourney
//
//  Created by Somaiya on 06/05/1447 AH.
//

import Foundation

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
