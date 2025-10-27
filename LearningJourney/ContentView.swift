//
//  ContentView.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Query var goals: [Goal] // Add SwiftData query
    
    var currentGoal: Goal? {
        goals.first // Or however you determine the current goal
    }

    var body: some View {
    
        NavigationStack{
            if currentGoal?.title.isEmpty ?? true {
                OnboardingView()
            } else {
//                ActivityView()
                SavedDataView()

            }


        }

    }
}

#Preview {
    ContentView()
      
}
