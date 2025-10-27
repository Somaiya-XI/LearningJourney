//
//  PrimaryButtom.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import SwiftUI

struct PrimaryButton: View {
    var label: String = "Log as Learned"
    
    var fillColor: Color = Color.accentPrimary
    var isDisabled : Bool

    var action: () -> Void =
    {
        print("Empty Action")
    }
    
    var body: some View {
        VStack{
            Text(label)
                .multilineTextAlignment(.center)
                .padding()
                .font(.system(size: 36))
                .bold()
                .foregroundStyle(.white)
                .frame(width: 274, height: 274)
                .glassEffect(.clear.interactive( !isDisabled).tint(isDisabled ? fillColor.opacity(0.1): fillColor))
                .onTapGesture {
                    action()
                }.disabled(isDisabled)
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
            //                    .foregroundStyle(.foreground).disabled(true)
            
        }
        
        
    }
}

#Preview {
    PrimaryButton(isDisabled: false)
}
