//
//  CalendarView.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    
    @State var vm = ViewModel()
    
//    @Query private var days: [Day]
    
    @Query var goals: [Goal]
    
    var currentGoal: Goal? {
        goals.first
    }
    
    var days: [Day] {
        currentGoal?.days ?? []
    }
    
    var body: some View {
        ScrollViewReader{ proxy in
            ScrollView{
                VStack(spacing: 12){
                    
                    ForEach(vm.GenerateMonth(), id: \.self){
                        month in
                        VStack(alignment: .leading,spacing: 8){
                            Text(vm.formatter.string(from: month)).font(.headline)
                            
                            HStack{
                                ForEach(vm.weekdays.indices, id: \.self){
                                    i in
                                    Text(vm.weekdays[i])
                                        .font(.footnote)
                                        .textCase(.uppercase).frame(maxWidth: .infinity)
                                        .foregroundStyle(.accentTernaryTxt)
                                }
                            }
                        }
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 7){
                            ForEach(vm.GenerateMonthGrid(for: month), id: \.self){ date in
                                dayCell(for: date, in: month)
                            }
                        }
                        
                        Spacer().frame(height: 1)
                        
                        Divider()
                            .frame(height: 0.5).background(.divider).padding(.bottom, 24)
                            .id(month)
                        
                    }
                    
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        proxy.scrollTo(vm.displayedMonth, anchor: .center)
                    }
                }
                
            }.padding(.horizontal, 16)
        }.navigationTitle("All activities")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func dayCell(for date: Date, in month: Date) -> some View {
        let isCurrentMonth = vm.calendar.isDate(date, equalTo: month, toGranularity: .month)
        
        if isCurrentMonth {
            
            let matchingDay = days.first { day in
                vm.calendar.isDate(day.date, inSameDayAs: date)
            }
            
            let bgColor: Color = {
                if vm.calendar.isDateInToday(date) && matchingDay === nil {
                    return .accentPrimary
                }
                if let status = matchingDay?.dayStatus {
                    return status == .Learn ? .accentPrimary.opacity(0.24) : .accentSecondary.opacity(0.24)
                }
                return .clear
            }()

            let txtColor: Color = {
                if vm.calendar.isDateInToday(date) && matchingDay === nil{
                    return .white
                }
                if let status = matchingDay?.dayStatus {
                    return status == .Learn ? .accentPrimary : .accentSecondary
                }
                return .foregroundAccent
            }()
            
            Text("\(vm.calendar.component(.day, from: date))")
                .frame(minWidth: 29)
                .foregroundStyle(txtColor)
                .font(.system(size: 24, weight: .medium))
                .padding(7.5)
                .background(bgColor)
                .clipShape(.circle)
        } else {
            Color.clear.frame(minWidth: 29)
        }
    }
}



#Preview {
    CalendarView()
}
