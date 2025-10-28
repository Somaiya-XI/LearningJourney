//
//  SecondaryButton.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

struct SecondaryButton: View {
    var label: String = "Set new learning goal"
    var fillColor: Color = Color.accentTernary
    var width: CGFloat = 223
    var height: CGFloat = 20
    var isDisabled : Bool = false
    var action: () -> Void =
    {
        print("Empty Action")
    }

    
    var body: some View {
        Text(label)
            .frame(width: width, height: height)
            .padding(.horizontal, 21)
            .padding(.vertical,14)
            .font(.body).fontWeight(.medium)
            .glassEffect(.clear.interactive( !isDisabled).tint(!isDisabled ? fillColor :  fillColor.opacity(0.2)))
            .onTapGesture {
                action()
            }.disabled(isDisabled)
    }
}

#Preview {
    SecondaryButton()
}
