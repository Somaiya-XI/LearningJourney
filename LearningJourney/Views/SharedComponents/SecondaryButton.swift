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
        Button{
            action()
        } label:{
            Text(label).font(.body).fontWeight(.medium).frame(width: width, height: height)
        }
        .buttonStyle(.glassProminent)
        .tint(fillColor)
        .disabled(isDisabled)
    }
}

#Preview {
    SecondaryButton()
}
