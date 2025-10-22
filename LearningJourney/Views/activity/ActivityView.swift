//
//  ActivityView\.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

enum Pages : Identifiable, CaseIterable, View{
    case goalPage, calendar
    var id: Self {self}
    var body: some View {
        switch self{
        case .calendar:
            CalendarView()
        case .goalPage:
            ChangeGoalView()
        }
    }

}

struct ActivityView: View {
    @State var disabled = false
    @State private var selectedPage: Pages?

    var body: some View {
        VStack(spacing: 32){
            HomeCalendar().padding(.top,24)
            PrimaryButton(fillColor:.accentPrimaryExact,isDisabled: disabled)
            VStack (spacing: 12){
                SecondaryButton(label: "Log as Freezed", fillColor: .accentSecondary.opacity(0.6), width: 232)
                
                Text("1 out of 2 Freezes used ")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.accentTxtMuted)
            }
            Spacer()

        }.navigationTitle("Activity")
        .toolbar{
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("", systemImage: "calendar"){
                    selectedPage = .calendar
                }


            }
            ToolbarSpacer(.fixed, placement: .topBarTrailing)
            ToolbarItem(placement: .topBarTrailing){
                Button("", systemImage: "pencil.and.outline"){
                    selectedPage = .goalPage

                }
            }
        }.toolbarTitleDisplayMode(.inlineLarge)
          .navigationBarBackButtonHidden()
          .navigationDestination(item: $selectedPage) { page in
              page.body
          }
        

        
        
    }
}

#Preview {
    ActivityView()
}
