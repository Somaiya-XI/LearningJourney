//
//  PrimaryButtom.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import SwiftUI
import SwiftData

struct PrimaryButton: View {
    @Environment(ViewModel.self) private var vm
    @Query var goals: [Goal]
    
    var currentGoal: Goal? {
        goals.first
    }

    var textProps: (text: String, foregroundColor: Color, fillColor: Color) = ("Log as Learned", .secondary, .accentPrimary)
    var isDisabled : Bool

    var action: () -> Void =
    {
        print("Empty Action")
    }
    
    var body: some View {
        VStack{
            Text(textProps.text)
                .multilineTextAlignment(.center)
                .padding()
                .font(.system(size: 36))
                .bold()
                .foregroundStyle(textProps.foregroundColor)
                .frame(width: 274, height: 274)
                .glassEffect(.clear.interactive( !isDisabled).tint(textProps.fillColor))
                .onTapGesture {
                    if !isDisabled {
                        action()
                    }                }.disabled(isDisabled)
            //
            //                Button("Log as learned"){}
            //                    .buttonStyle(.bordered)
            //                    .tint(.accentTernary)
            //                    .glassEffect(.clear.interactive()                    .tint(.accentTernary)
            //)
            //                    .foregroundStyle(.foreground).disabled(false)
            //
            //
            //                Button("Log as learnsd"){}
            //                    .buttonStyle(.bordered)
            //                    .glassEffect(.clear.interactive(false)                    .tint(.accentPrimaryDisabled.opacity(0.5))
            //)
            //                    .foregroundStyle(.accentPrimaryTxt).disabled(true)
            //
            //
            //                Button("Log as learnsd"){}
            //                    .buttonStyle(.glassProminent)
            //                    .tint(.accentPrimary)
            //                    .glassEffect(.clear)
            
        }
        
        
    }
}

#Preview {
    PrimaryButton(isDisabled: false)
         .environment(ViewModel())}
