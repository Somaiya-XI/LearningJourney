//
//  LearningGoalView.swift
//  LearningJourney
//
//  Created by Somaiya on 30/04/1447 AH.
//

import SwiftUI

struct ChangeGoalView: View {
    @State var goalTitle = ""
    @State var showAlert: Bool = false
    var body: some View {
        VStack{
            GoalForm(goalTitle: $goalTitle)
            Spacer()
//            Button("", systemImage: "checkmark"){
//                showAlert.toggle()
//                
//            }

        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Update Learning goal"))
        }.padding(.horizontal, 17)
            .padding(.vertical, 32)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("", systemImage: "checkmark"){
                        showAlert.toggle()
                        
                    }
                }
            }
    }
}

#Preview {
    ChangeGoalView()
}
