//
//  ActivityView\.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI
import SwiftData

struct ActivityView: View {
    @Environment(ViewModel.self) private var vm
    @Environment(\.modelContext) var context
    
    @Query var goals: [Goal] // Add SwiftData query
    
    var currentGoal: Goal? {
        goals.first // Or however you determine the current goal
    }
    var body: some View {
        VStack(spacing: 32){
            HomeCalendar()
                .padding(.top,24)
                .padding(.leading, 14)
                .padding(.trailing, 14)
            
            PrimaryButton(label: vm.isLearned ? "Learned   Today" : "Log as Learned", fillColor:.accentPrimaryExact,isDisabled: vm.isLearned || vm.isFreezed) {
                vm.isLearned = true
                currentGoal?.streak += 1
                let day = Day(date: Date(), dayStatus: .Learn)
                context.insert(day)
                try? context.save()

            }
            VStack (spacing: 12){
                SecondaryButton(label: "Log as Freezed", fillColor: .accentSecondary.opacity(0.6), width: 232, isDisabled: vm.isFreezed || vm.isLearned) {
                    vm.isFreezed = true
                    currentGoal?.freez += 1
                    let day = Day(date: Date(), dayStatus: .Freeze)
                    context.insert(day)
                    try? context.save()
                }
                
                // checking if there is a retrieved goal then returning the st
                if let goal = currentGoal {
                    Text("\(goal.freez) out of \(vm.getMaxFreezes(for: goal.learningDuration)) Freezes left")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.accentTxtMuted)
                }
            }
            Spacer()
            
            
        }.navigationTitle("Activity")
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "calendar"){
                        vm.selectPage(p: .calendar)
                    }
                    
                    
                }
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                ToolbarItem(placement: .topBarTrailing){
                    Button("", systemImage: "pencil.and.outline"){
                        vm.selectPage(p: .goalPage)
                        
                    }
                }
            }.toolbarTitleDisplayMode(.inlineLarge)
            .navigationBarBackButtonHidden()
            .navigationDestination(item:  Bindable(vm).selectedPage) { page in
                page.body
            }
        
    }
    
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, Goal.self, configurations: config)
    let viewModel = ViewModel()
    
     ActivityView()
        .environment(viewModel)
        .modelContainer(container)
}
