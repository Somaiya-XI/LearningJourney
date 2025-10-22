//
//  SelectionBadge.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

struct SelectionBadge: View {
    var text = "Month"
    @State var selected: Bool = true
    @State var fillColor = Color.accentPrimaryExact
    var body: some View {
        Text(text).font(.headline).fontWeight(.medium).frame(width:97, height: 48).glassEffect(.clear.interactive().tint(fillColor))
            .onTapGesture {
                selected = !selected
            }
            .onChange(of: selected,  {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if !selected {
                        
                        fillColor = Color.clear}
                    else{
                        fillColor = Color.accentPrimaryExact
                    }
                }
                
           
        }).onAppear(perform: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if !selected {
                        
                        fillColor = Color.clear}
                    else{
                        fillColor = Color.accentPrimaryExact
                    }
                }
            })
    }
    
}

#Preview {
    SelectionBadge()
}
