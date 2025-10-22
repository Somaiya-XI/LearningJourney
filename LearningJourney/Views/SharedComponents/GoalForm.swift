//
//  GoalForm.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

struct GoalForm: View {
    @Binding var goalTitle: String
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4){
            Text("I want to learn").font(.title2)
            TextField("Swift", text: $goalTitle).tint(.accentPrimary)
                .frame(height: 48)
        }
        VStack(alignment: .leading, spacing: 24){
            Divider().frame(height: 1).background(.separator)
            
            Text("I want to learn it in a").font(.title2)
                .foregroundStyle(.bodyText)
                .padding(0)
        }
        
        HStack(alignment: .center, spacing: 8){
            SelectionBadge(text: "Week", selected: true)
            SelectionBadge(selected: false)
            SelectionBadge(text: "Year", selected: false)
            
            Spacer()
            
        }
        
    }
}


