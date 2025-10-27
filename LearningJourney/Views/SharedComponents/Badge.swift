//
//  Badge.swift
//  LearningJourney
//
//  Created by Somaiya on 28/04/1447 AH.
//

import SwiftUI



struct Badge: View {
    @State var vm = ViewModel()
    var status: DayStatus = .Learn
    var count = 0

    var iconName: String {
        status == .Learn ?  "flame.fill" : "cube.fill"
    }
    var fillColor: Color {
        status == .Learn ? Color.accentPrimaryMuted : Color.accentSecondaryMuted
}
    var txtColor: Color {
        status == .Learn ? Color.accentPrimaryTxt : Color.accentSecondaryTxt
}
    var body: some View {
        
        HStack (alignment: .center, spacing: 0){
            
            Image(systemName: iconName)
                .frame(width: 41, height: 41)
                .foregroundStyle(txtColor)
                .font(.title3)


            VStack(alignment: .leading, spacing: 0){
                Text("\(count)").font(.system(size: 24, weight: .semibold))
                 Text("\(vm.label)")
                    .font(.caption)
            }
            
            Spacer()

        }.padding(.horizontal, 14)
            .frame(width: 160, height: 69)
            .background(fillColor)
            .cornerRadius(34)
        
        .onAppear(perform: {
            vm.setView(status: status, count: count)
            })
}
    
}

#Preview {
    Badge()
}
