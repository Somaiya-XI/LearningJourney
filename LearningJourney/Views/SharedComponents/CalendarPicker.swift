//
//  CalendarPicker.swift
//  LearningJourney
//
//  Created by Somaiya on 28/04/1447 AH.
//

import SwiftUI
import SwiftData

struct CalendarPicker: View {
    @State var vm = ViewModel()
    
    @Query var goals: [Goal]
    
    var currentGoal: Goal? {
        goals.first
    }
    
    var days: [Day] {
        currentGoal?.days ?? []
    }
    
    var body: some View {
        let weekDays = vm.GenerateWeekGrid()
        
        VStack(spacing: 12){
            HStack (spacing: 0){
                
                /* MONTH EXPANDING FUNC */
                Button{}label:{
                    Text(vm.formatter.string(from: vm.displayedMonth)).font(.headline)
                    Image(systemName: "chevron.right").font(.footnote).bold().foregroundStyle(.orange)
                }.buttonStyle(.plain)
                Spacer()
                
                HStack{
                    /* GOING TO PREVIOUS WEEKS/MONTHS */
                    Button {
                        withAnimation(.snappy){vm.ChangeWeek(by: -1); vm.ChangeMonth(by: -1)}
                    } label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 15, height: 24)
                                .foregroundStyle(.accentPrimary)
                                .font(.title3).fontWeight(.semibold).padding(.trailing, 14)
                        }
                    
                    /* GOING TO NEXT WEEKS/MONTHS */
                    Button {
                        withAnimation(.snappy){vm.ChangeWeek(by: 1); vm.ChangeMonth(by: 1)}
                    } label: {
                        Image(systemName: "chevron.right")
                            .frame(width: 15, height: 24)
                            .foregroundStyle(.accentPrimary)
                            .font(.title3).fontWeight(.semibold)
                            .padding(.leading, 14)
                    }
                }
            }
            
            
            /* DAYS HEADER */
            HStack{
                ForEach(vm.weekdays.indices, id: \.self){
                    i in
                    Text(vm.weekdays[i])
                        .font(.footnote)
                        .textCase(.uppercase).frame(maxWidth: .infinity)
                        .foregroundStyle(.accentTernaryTxt)
                }
            }
            
            /* GRID OF 7 DAYS */
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 2){
                
                // looping over each day of week and apply propper styling
                ForEach(weekDays, id: \.self){
                    date in
                
                    dayCell(for: date)
                }
                
                
                
            }
            Spacer().frame(height: 1)
            Divider()
                .frame(height: 0.5).background(.divider)
            
        }
        
        
        
        
    }
    
    @ViewBuilder
    private func dayCell(for date: Date) -> some View {
            
            let matchingDay = days.first { day in
                vm.calendar.isDate(day.date, inSameDayAs: date)
            }
            
            let bgColor: Color = {
                if vm.calendar.isDateInToday(date) && matchingDay == nil {
                    return .accentPrimary
                }
                if let status = matchingDay?.dayStatus {
                    return status == .Learn ? .accentPrimary.opacity(0.24) : .accentSecondary.opacity(0.24)
                }
                return .clear
            }()

            let txtColor: Color = {
                if vm.calendar.isDateInToday(date) && matchingDay == nil{
                    return .white
                }
                if let status = matchingDay?.dayStatus {
                    return status == .Learn ? .accentPrimary : .accentSecondary
                }
                return .white
            }()
            
            Text("\(vm.calendar.component(.day, from: date))")
                .frame(minWidth: 29)
                .foregroundStyle(txtColor)
                .font(.system(size: 24, weight: .medium))
                .padding(7.5)
                .background(bgColor)
                .clipShape(.circle)
        }
    
}

#Preview {
    CalendarPicker()
}

