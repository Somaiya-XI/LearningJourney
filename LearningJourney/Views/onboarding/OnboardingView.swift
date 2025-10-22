//
//  OnBoardingView.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import SwiftUI

struct OnboardingView: View {
    @State var goalTitle = ""
    @State var start = false
    var body: some View {
        VStack{
            
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
                GoalForm(goalTitle: $goalTitle)
                
            }.padding(.horizontal, 13)
            Spacer()
            SecondaryButton(label: "Start learning",
                            fillColor:.accentPrimaryExact,width: 140, action: {
                if goalTitle.isEmpty {
                    start = true
                    
                    
                }
            })
        }.navigationDestination(isPresented: $start){
            ActivityView()
        }
        
    }
}

#Preview {
    OnboardingView()
}
