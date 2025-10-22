//
//  CalendarPicker.swift
//  LearningJourney
//
//  Created by Somaiya on 28/04/1447 AH.
//

import SwiftUI

struct CalendarPicker: View {
    @State var displayedWeek: Date
    @State var displayedMonth: Date
    
    let calendar = Calendar.current
    let formatter: DateFormatter =
    {
        let f = DateFormatter()
        f.dateFormat = "MMMM YYYY"
        return f
    }()
    
    var weekdays: [String] {
        let days = calendar.shortWeekdaySymbols
        return Array(days)
    }
    
    var todayIndex: Int {
        // getting the index of today from the calendar component
        let originIndex = calendar.component(.weekday, from: Date()) - 1
        return originIndex
    }
    
    func ChangeWeek(by value: Int){
        displayedWeek = calendar.date(byAdding: .weekOfMonth, value: value, to: displayedWeek) ?? displayedWeek
    }
    
    func ChangeMonth(by value: Int){
        displayedMonth = calendar.date(byAdding: .weekOfMonth, value: value, to: displayedMonth) ?? displayedMonth
    }
    

    
    
    func GenerateWeekGrid() -> [Date]{
        guard let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: displayedWeek),
              let startOfWeek = calendar.dateInterval(of: .day, for: weekInterval.start),
              let endOfWeek = calendar.dateInterval(of: .day, for: weekInterval.end - 1)
        else {return []}
        return stride(from: startOfWeek.start,
                      to: endOfWeek.end, by: 86400).map {$0}
    }
    
    
    var body: some View {
        let weekDays = GenerateWeekGrid()
        
        VStack(spacing: 12){
            HStack (spacing: 0){
                Button{}label:{
                    Text(formatter.string(from: displayedMonth)).font(.headline)
                    Image(systemName: "chevron.right").font(.footnote).bold().foregroundStyle(.orange)
                }.buttonStyle(.plain)
                Spacer()

                HStack{
                    Button{
                        withAnimation(.snappy){
                            ChangeWeek(by: -1)
                            ChangeMonth(by: -1)
}                    } label: {
                                Image(systemName: "chevron.left")
        .frame(width: 15, height: 24)
        .foregroundStyle(.accentPrimary)
        .font(.title3).fontWeight(.semibold).padding(.trailing, 14)
                            }
                    Button{
                        withAnimation(.snappy){
                            ChangeWeek(by: 1)
                            ChangeMonth(by: 1)
}
                        
                    } label: {
                        Image(systemName: "chevron.right")                .frame(width: 15, height: 24)
                            .foregroundStyle(.accentPrimary)
                            .font(.title3).fontWeight(.semibold)
                            .padding(.leading, 14)
                    }    }
                
            }
            
            
            HStack{
                ForEach(weekdays.indices, id: \.self){
                    i in
                    Text(weekdays[i])
                        .font(.footnote)
                        .textCase(.uppercase).frame(maxWidth: .infinity)
                        .foregroundStyle(.accentTernaryTxt)
                }
                
            }.frame(width: .infinity)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 2){
                
                ForEach(weekDays, id: \.self){
                    date in
                    
                    if calendar.isDateInToday(date) {
                        Text("\(calendar.component(.day, from: date))")
                            .font(.system(size: 24, weight: .medium) )
                            .background(
                                Circle().frame(width: 44, height: 44)
                                    .foregroundStyle(.accentPrimaryTxt))
                    
                }
                    else
                    {
                        Text("\(calendar.component(.day, from: date))")  .foregroundStyle(.accentPrimaryTxt)
                            .font(.system(size: 24, weight: .medium) )
                            .background(
                                Circle().frame(width: 44, height: 44)
                                    .foregroundStyle(.accentPrimaryTxt.opacity(0.24))
                                
                            )}
                    
                }
            }
            
            
            //            VStack{
            //            DatePicker("", selection: .constant(Date()), displayedComponents: .date )
            //                .tint(.accentPrimaryTxt)                .datePickerStyle(.graphical)
            //            }
            Spacer().frame(height: 1)
            Divider()
                .frame(height: 0.5).background(.divider)
            
        }
        
        
        
        
    }
}

#Preview {
    CalendarPicker(displayedWeek: Date(), displayedMonth: Date())
}

