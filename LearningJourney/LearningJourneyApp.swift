//
//  LearningJourneyApp.swift
//  LearningJourney
//
//  Created by Somaiya on 27/04/1447 AH.
//

import SwiftUI
import SwiftData
@main
struct LearningJourneyApp: App {
    init() {
        // Configure alert tint color
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(named: "accentPrimary")
    }
    @State private var viewModel = ViewModel()

    var body: some Scene {
        
        WindowGroup {
            ContentView().preferredColorScheme(.dark)
        }
        .environment(viewModel)
        .modelContainer(for: [Day.self, Goal.self])
        
    }
}
