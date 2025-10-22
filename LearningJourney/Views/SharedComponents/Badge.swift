//
//  Badge.swift
//  LearningJourney
//
//  Created by Somaiya on 28/04/1447 AH.
//

import SwiftUI

enum DayStatus {case Learn, Freeze}


struct Badge: View {
    @State var labelPrefix: String = "Days"
    @State var label: String = ""
    var status: DayStatus = .Learn
    var iconName: String {
        status == .Learn ?  "flame.fill" : "cube.fill"
    }
    var fillColor: Color {
        status == .Learn ? Color.accentPrimaryMuted : Color.accentSecondaryMuted
}
    var txtColor: Color {
        status == .Learn ? Color.accentPrimaryTxt : Color.accentSecondaryTxt
}
    @State var digit: Int = 0
    var body: some View {
        
        HStack (alignment: .center, spacing: 0){
            
            Image(systemName: iconName)
                .frame(width: 41, height: 41)
                .foregroundStyle(txtColor)
                .font(.title3)


            VStack(alignment: .leading, spacing: 0){
                Text("\(digit)").font(.system(size: 24, weight: .semibold))
                
                Text("\(label)")
                    .font(.caption)
                
                
            }
            Spacer()

        }.padding(.horizontal, 14)
            .frame(width: 160, height: 69)
                    .background(fillColor)
            .cornerRadius(34)

        
        .onAppear(perform: {
            if digit == Int(1) || digit == Int(0) {
                labelPrefix = "Day"
            }
            else{
                labelPrefix = "Days"
            }
            switch status {
            case .Learn:
                label = "\(labelPrefix) Learned"
            case .Freeze:
                label = "\(labelPrefix) Freezed"

            }
            })
        
        
    }
    
}

#Preview {
    Badge()
}
