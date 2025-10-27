//
//  SelectionBadge.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

struct SelectionBadge: View {
    var text = "Month"
    var selected: Bool = true
    var fillColor = Color.accentPrimaryExact
    var body: some View {
        
        Text(text).font(.headline).fontWeight(.medium).frame(width:97, height: 48)
            .glassEffect(.clear.interactive().tint(selected ? fillColor: Color.clear))
            .animation(.easeInOut(duration: 0.35), value: selected)
        
    }
}



#Preview {
    SelectionBadge()
}
