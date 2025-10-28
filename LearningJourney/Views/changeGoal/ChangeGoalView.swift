//
//  LearningGoalView.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI
import SwiftData

struct ChangeGoalView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Environment(ViewModel.self) private var vm
    @Query var goals: [Goal]
    
    var currentGoal: Goal? {
        goals.first
    }
    
    var body: some View {
        @Bindable var vm = vm
        VStack{
            GoalForm()
            Spacer()
        }
        .alert("Update Learning goal", isPresented: $vm.showAlert) {
            Button("Dismiss", role: .cancel) {
                dismiss()
            }
            Button("Update") {
                vm.updateGoal(goal: currentGoal, context)
                dismiss()
            }.keyboardShortcut(.defaultAction)
        } message: {
            Text("If you update now, your streak will start over.")
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 32)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("", systemImage: "checkmark") {
                    vm.AlertUser()
                }.tint(.accentPrimary)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, Goal.self, configurations: config)
    let viewModel = ViewModel()
    
     ChangeGoalView()
        .environment(viewModel)
        .modelContainer(container)
}
