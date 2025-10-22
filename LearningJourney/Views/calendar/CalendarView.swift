//
//  CalendarView.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

struct CalendarView: View {
    @State var displayedWeek: Date = Date()
    @State var displayedMonth: Date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month],from: Date())) ?? Date()
    @State var currentVisibleMonth = Date()
    
    let calendar = Calendar.current
    
    let formatter: DateFormatter =
    {
        let f = DateFormatter()
        f.dateFormat = "MMMM YYYY"
        return f
    }()
    
    let dayformatter: DateFormatter =
    {
        let f = DateFormatter()
        f.dateFormat = "D"
        return f
    }()
    
    func GenerateMonth()-> [Date]{
        var months: [Date] = []
        let currentYear = calendar.component(.year, from: Date())
        for month in 1...12 {
            if let date = calendar.date(from: DateComponents(year: currentYear, month: month)){
                months.append(date)
            }
        }
        return months
    }
    
    func GenerateMonthGrid(for month: Date) -> [Date]{
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else {return []}
        
        return stride(from: monthInterval.start,
                      to: monthInterval.end, by: 86400).map {$0}
    }
    
    var weekdays: [String] {
        let days = calendar.shortWeekdaySymbols
        return Array(days)
    }
    
    
    
    var body: some View {
        ScrollViewReader{ proxy in
            ScrollView{
                VStack(spacing: 12){
                    
                    ForEach(GenerateMonth(), id: \.self){
                        month in
                        VStack(alignment: .leading,spacing: 8){
                            Text(formatter.string(from: month)).font(.headline)
                            
                            HStack{
                                ForEach(weekdays.indices, id: \.self){
                                    i in
                                    Text(weekdays[i])
                                        .font(.footnote)
                                        .textCase(.uppercase).frame(maxWidth: .infinity)
                                        .foregroundStyle(.accentTernaryTxt)
                                }
                                
                            }.frame(width: .infinity)
                            
                        }
                        
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7), spacing: 30){
                            ForEach(GenerateMonthGrid(for: month), id: \.self){ date in
//                                let isCurrentMonth = calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
                                if calendar.isDateInToday(date) {
                                    Text("\(calendar.component(.day, from: date))")
                                        .font(.system(size: 24, weight: .medium) )
                                        .background(
                                            Circle().frame(width: 44, height: 44)
                                                .foregroundStyle(.accentPrimaryTxt))
                                    
                                }
                                else{
                                    Text("\(calendar.component(.day, from: date))")  .foregroundStyle(.accentPrimaryTxt)
                                        .font(.system(size: 24, weight: .medium) )
                                        .background(
                                            Circle().frame(width: 44, height: 44))
                                        .foregroundStyle(.accentPrimaryTxt.opacity(0.24))
                                }
                                
                                
                                
                                
                            }
                            
                            
                        }
                        
                        Spacer().frame(height: 1)
                        Divider()
                            .frame(height: 0.5).background(.divider).padding(.bottom, 24)
                            .id(month)
                        
                    }
                    
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        proxy.scrollTo(displayedMonth, anchor: .center)
                    }
                }
                
            }.padding(.horizontal, 16)
        }.navigationTitle("All activities")
            .navigationBarTitleDisplayMode(.inline)
    }}

#Preview {
    CalendarView()
}
