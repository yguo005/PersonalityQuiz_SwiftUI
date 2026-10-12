//
//  IntroductionView.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import SwiftUI

// MARK: - Step 4: Add Navigation Logic
// Think: "I need to remember if the quiz is active, and navigate when the button is tapped"
struct IntroductionView: View {
    // @State = this view OWNS this data and can change it
    // Think: like a private instance variable that triggers re-rendering when changed
    @State private var quizActive = false
    
    var body: some View {
        // NavigationStack = enables push/pop navigation (like Android's Fragment stack)
        NavigationStack {
            VStack {
                Spacer()
                
                HStack {
                    //Text("🐱")
                    Text("🦁")
                    Spacer()
                    //Text("🐢")
                    Text("🦡")
                    
                }
                .font(.system(size: 60))
                
               
                Text("Which Hogwarts House Are You?")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 40)
                
                HStack {
                    
                    Text("🦅")
                    Spacer()
                    
                    Text("🐍")
                }
                .font(.system(size: 60))
                
                Spacer()
                
                //Button("Begin Personality Quiz")
                Button("Begin Sorting") {
                    quizActive = true  // This triggers navigation!
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 40)
            // When quizActive becomes true, push QuestionView
            .navigationDestination(isPresented: $quizActive) {
                QuestionView(quizActive: $quizActive)
            }
            // MARK: - Run Tests When View Appears (DISABLED - Tests Complete!)
            // Think: ".onAppear runs once when this view first shows up"
            // It's like componentDidMount in React or viewDidLoad in UIKit
            // .onAppear {
            //     testModels()  // Call the test function from Models.swift
            // }
        }
    }
}

// Preview lets you see your view while coding
#Preview {
    IntroductionView()
}
