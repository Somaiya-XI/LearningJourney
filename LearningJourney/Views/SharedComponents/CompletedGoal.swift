//
//  CompletedGoal.swift
//  LearningJourney
//
//  Created by Somaiya on 05/05/1447 AH.
//

import SwiftUI
import SwiftData

struct CompletedGoal: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Environment(ViewModel.self) private var vm
    @Query var goals: [Goal]
    
    var currentGoal: Goal? {
        goals.first
    }
    
    var body: some View {
        VStack(spacing: 8){
            
            Image(systemName: "hands.and.sparkles.fill")
                .frame(width: 41, height: 41)
                .foregroundStyle(.accentPrimary)
                .font(.system(size: 40))
            
            VStack (spacing: 4){
                Text("Well done!").font(.title2).bold()
                Text("Goal completed! start learning again\nor set new learning goal")
                    .multilineTextAlignment(.center)
                    .font(.system(size:18, weight: .medium))
                    .lineHeight(.leading(increase: 10))
                    .foregroundStyle(.accentTxtMuted)}
            Spacer().frame(height: 70)
            SecondaryButton(label: "Set new learning goal", fillColor: .accentPrimaryExact.opacity(0.6), width: 232)
            Spacer()
            Text("Set Same")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.accentPrimary)
                .onTapGesture {
                    vm.updateGoal(goal: currentGoal, context)
                }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, Goal.self, configurations: config)
    let viewModel = ViewModel()
    
    CompletedGoal()
        .environment(viewModel)
        .modelContainer(container)
}
