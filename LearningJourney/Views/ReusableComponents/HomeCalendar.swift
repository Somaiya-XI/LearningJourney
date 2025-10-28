//
//  HomeCalendar.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI
import SwiftData
struct HomeCalendar: View {
    
    @State var vm = CalendarPicker.ViewModel()


    @Query var goals: [Goal]
    var currentGoal: Goal? {
        goals.first
    }
    
    private let goalTitle = "Learning Swift"
    var body: some View {
        VStack (alignment: .leading){
            CalendarPicker(vm: vm)
            if !vm.isWeelView {
                Text(currentGoal?.title ?? goalTitle).font(.callout).fontWeight(.semibold)
                HStack{
                    
                    Badge(status: .Learn, count: currentGoal?.streak ?? 0)
                    Spacer()
                    Badge(status: .Freeze, count: currentGoal?.freeze ?? 0)
                }
            }
        }
        .frame(height: 254)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .glassEffect(.regular, in: .rect(cornerRadius: 13) )
    }
}

#Preview {
    HomeCalendar().tint(.accentPrimary)
}
