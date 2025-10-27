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
    
    @Query var goals: [Goal]
    
    var currentGoal: Goal? {
        goals.first
    }
    
    var textProp: (text: String, foregroundColor: Color, fillColor: Color) {
           if currentGoal == nil {
               return (text: "Log as Learned", foregroundColor: Color.foregroundAccent, fillColor: Color.accentPrimaryExact )
           }
           
           if currentGoal!.isLearned {
               return (text: "Learned  Today", foregroundColor: Color.accentPrimaryTxt, fillColor: Color.accentPrimary.opacity(0.1))
           } else if currentGoal!.isLoggedToday {
               return (text: "Day Freezed", foregroundColor: Color.accentSecondaryTxt, fillColor: Color.accentPrimary.opacity(0.1))
           } else {
               return (text: "Log as Learned", foregroundColor: Color.foregroundAccent, fillColor: Color.accentPrimaryExact )
           }
       }
       
       // Primary button should be disabled if any log exists today
       var isPrimaryDisabled: Bool {
           currentGoal?.isLoggedToday ?? false
       }
       
       // Freeze button disabled if: logged today OR max freeze reached
       var isFreezeDisabled: Bool {
           (currentGoal?.isLoggedToday ?? false) || vm.isMaxFreeze
       }
    
    var body: some View {

        
        VStack(spacing: 32){
            HomeCalendar()
                .padding(.top,24)
                .padding(.leading, 14)
                .padding(.trailing, 14)
            
            PrimaryButton(
                textProps: textProp,
                isDisabled: isPrimaryDisabled
            ) {
                vm.logAsLearned(goal: currentGoal, context)
            }
            
            VStack (spacing: 12){

                SecondaryButton(
                    label: "Log as Freezed",
                    fillColor: .accentSecondary.opacity(0.6),
                    width: 232,
                    isDisabled: isFreezeDisabled
                ) {
                    vm.logAsFreezed(goal: currentGoal, context)
                }
                
                // checking if there is a retrieved goal then returning the st
                if let goal = currentGoal {
                    Text("\(goal.freeze) out of \(vm.getMaxFreezes(for: goal.learningDuration)) Freezes left")
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
