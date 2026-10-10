//
//  PersonalityQuiz_SwiftUIApp.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import SwiftUI

@main
struct PersonalityQuiz_SwiftUIApp: App {
    
    // MARK: - Initializer runs before any UI appears
    // Think: "This is like the main() entry point in Java"
    init() {
        // Run tests when app launches
        // testModels()
    }
    
    var body: some Scene {
        WindowGroup {
            // Changed from ContentView to IntroductionView
            // Think: This is like the "main activity" or entry point
            IntroductionView()
        }
    }
}
