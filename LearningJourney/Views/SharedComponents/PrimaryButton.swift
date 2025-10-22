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
    var action: () -> Void =
    {
        print("Empty Action")
    }
    var isDisabled : Bool
    
    var body: some View {
            VStack{
                Text(label)
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.system(size: 36))
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: 274, height: 274)
                    .glassEffect(.clear.interactive( !isDisabled).tint(fillColor))
                    .onTapGesture {
                        action()
                    }.disabled(isDisabled)
            }
        
//        Button("Add"){}
//            .buttonStyle(.glassProminent)
//            .tint(.accentPrimary)
//        Text("Month")
//            .frame(width: 200, height: 34)
//            .glassEffect(
//                .clear
//                    .interactive()
//                    .tint(.accentSecondaryMuted)
//            )
        
    }
}

#Preview {
    PrimaryButton(isDisabled: false)
}
