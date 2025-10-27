//
//  OnBoardingView.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import SwiftUI
import SwiftData

enum Selections : Identifiable, CaseIterable{
    case week, month, year
    var id: Self {self}
}

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(ViewModel.self) private var vm
    
    var body: some View {
        
        VStack {
            
            Image(systemName: "flame.fill")
                .foregroundStyle(.accentPrimary)
                .font(.system(size: 36, weight: .bold))
                .frame(width: 109, height: 109)
                .glassEffect(.clear.tint(.accentPrimaryDisabled))
                .padding(.bottom, 47).padding(.top, 24)
            
            VStack(alignment: .leading){
                VStack (alignment: .leading, spacing: 4){
                    Text("Hello Learner").font(.largeTitle).bold()
                    Text("This app will help you learn everyday!").font(.body)
                        .foregroundStyle(.bodyText)
                }
                .padding(.bottom, 31)
                GoalForm()
                
            }.padding(.horizontal, 13)
            Spacer()
            SecondaryButton(label: "Start learning",
                  fillColor:.accentPrimaryExact,width: 140, action: {
                vm.saveUserGoal(context: modelContext)


            })
        }
        .navigationDestination(isPresented:  Bindable(vm).isValidGoal){
            ActivityView()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, Goal.self, configurations: config)
    let viewModel = ViewModel()
    
     OnboardingView()
        .environment(viewModel)
        .modelContainer(container)
}
