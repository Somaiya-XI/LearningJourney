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
    
    @State var goToChaangeGoal = false
    
    var body: some View {
        VStack(spacing: 8){
            
            Image(systemName: "hands.and.sparkles.fill")
                .frame(width: 41, height: 41)
                .foregroundStyle(.accentPrimary)
                .font(.system(size: 40))
                .padding(.top, 62)
            
            VStack (spacing: 4){
                Text("Well done!").font(.title2).bold()
                Text("Goal completed! start learning again\nor set new learning goal")
                    .multilineTextAlignment(.center)
                    .font(.system(size:18, weight: .medium))
                    .lineHeight(.leading(increase: 10))
                    .foregroundStyle(.accentTxtMuted)}
            Spacer()
            SecondaryButton(label: "Set new learning goal", fillColor: .accentPrimaryExact, width: 232){
                goToChaangeGoal = true
            }
            
            Text("Set same learning goal and duration")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.accentPrimary)
                .onTapGesture {
                    vm.goalTitle = currentGoal?.title ?? ""
                    vm.updateGoal(goal: currentGoal, context)
                }.padding(.top, 8)
        }.navigationDestination(isPresented: $goToChaangeGoal) {
            ChangeGoalView()
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
