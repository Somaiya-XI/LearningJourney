//
//  HomeCalendar.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

struct HomeCalendar: View {
    @State var goalTitle = "Learning Swift"
    var body: some View {
        VStack (alignment: .leading){
            CalendarPicker(displayedWeek: Date(), displayedMonth: Date())
            Text(goalTitle).font(.callout).fontWeight(.semibold)
            HStack{
                
                Badge(status: .Learn)
                Spacer()
                Badge(status: .Freeze)
                
            }
        }.padding(.horizontal, 14)
        .frame(width: 365, height: 254)
        .glassEffect(.regular, in: .rect(cornerRadius: 13) )
    }
}

#Preview {
    HomeCalendar().tint(.accentPrimary)
}
