//
//  GoalForm.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI
import SwiftData
struct GoalForm: View {
    @Environment(ViewModel.self) private var vm

    var body: some View {
        @Bindable var vm = vm
        VStack(alignment: .leading, spacing: 4){
            Text("I want to learn").font(.title2)
            TextField("Swift", text: $vm.goalTitle)
            .tint(.accentPrimary)
                .frame(height: 48)
                .keyboardShortcut(.defaultAction)
        }
        VStack(alignment: .leading, spacing: 24){
            Divider().frame(height: 1).background(.separator)
            
            Text("I want to learn it in a").font(.title2)
                .foregroundStyle(.bodyText)
                .padding(0)
        }
        
        HStack(alignment: .center, spacing: 8) {
            ForEach(learningDuration.allCases) { duration in
                SelectionBadge(
                    text: duration.rawValue,
                    selected: vm.goalDuration == duration
                )
                .onTapGesture {
                    vm.goalDuration = duration
                }
            }
            
            Spacer()
        }
        
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, Goal.self, configurations: config)
    let viewModel = ViewModel()
    
     GoalForm()
        .environment(viewModel)
        .modelContainer(container)
}
