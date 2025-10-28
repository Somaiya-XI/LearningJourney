//
//  ContentView.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Query var goals: [Goal] 
    
    var currentGoal: Goal? {
        goals.first
    }
    var body: some View {
        NavigationStack{
            if currentGoal == nil || (currentGoal?.title.isEmpty ?? true) {
                OnboardingView()
            } else {
                ActivityView()
//                SavedDataView()
            }


        }

    }
}

#Preview {
    ContentView()
}
