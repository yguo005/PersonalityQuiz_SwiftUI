//
//  QuestionView.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import SwiftUI

// MARK: - The Main Question Screen
// Think: "This screen shows ONE question at a time, but cycles through all of them"

struct QuestionView: View {
    // MARK: - Step 1: Define Properties
    // Think: "What data does this screen need?"
    
    // Hint: You need a @Binding to quizActive (Bool)
    //   - Why @Binding? Because IntroductionView owns it, but we need to change it
    //   - When we finish the quiz, we'll set this to false to pop back to intro
    @Binding var quizActive: Bool
    
    // Hint: You need @State for questionIndex (Int)
    //   - Tracks which question we're showing (0, 1, 2...)
    //   - Start at 0
    //   - Why @State? Because THIS view owns it and changes it
    @State private var questionIndex = 0
    
    // Hint: You need @State for answersChosen ([Answer])
    //   - Stores all the answers the user has selected
    //   - Start as empty array: []
    //   - We'll append to this after each question
    @State private var answersChosen: [Answer] = []
    
    
    // Hint: You need @State for showResults (Bool)
    //   - Controls navigation to ResultsView
    //   - Start as false
    //   - Set to true after the last question
    @State private var showResults = false
    
    
    
    // MARK: - Step 2: Create Computed Properties
    // Think: "What values can I calculate from my properties?"
    // Hint: Create a computed property called 'question' that returns Question
    //   - Use: allQuestions[questionIndex]
    //   - This automatically updates when questionIndex changes!
    //   - Syntax: private var question: Question { ... }
    private var question: Question {
        allQuestions[questionIndex]
    }
    
    // Hint: Create a computed property called 'progress' that returns Double
    //   - Calculate: currentIndex / totalQuestions
    //   - Example: 0/3 = 0.0, 1/3 = 0.33, 2/3 = 0.67
    //   - Need to cast to Double: Double(questionIndex) / Double(allQuestions.count)
    private var progress: Double {
        Double(questionIndex)/Double(allQuestions.count)
    }
    
    
    // MARK: - Step 3: Build the UI
    var body: some View {
        // Hint: Use VStack with spacing: 24
        VStack(spacing: 24) {
            
            // Hint: Show the question text
            //   - Text(question.text)
            Text(question.text)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
            
            // Hint: Show a progress bar
            //   - ProgressView(value: progress)
            //   - This shows how far through the quiz we are
            ProgressView(value: progress)
            
            // Hint: Add Spacer() to push content apart vertically
            Spacer()
            
            // MARK: - Step 4: The Switch Statement (Key Logic!)
            // Think: "I need to show different UI based on question.type"
            
            // Hint: Wrap this in a Group { }
            Group {
                // Hint: Use a switch statement on question.type
                switch question.type {
                case .single:
                    //       // Show SingleAnswerView (you'll create this next)
                    //       // Pass: answers and a callback function
                    SingleAnswerView(answers: question.answers, // Pass the 4 answers
                                     choose: answered(with:))   // Pass callback function
                case .multiple:
                    //       // Show MultipleAnswerView
                    MultipleAnswerView(answers: question.answers, submit: answered(with:))
                case .ranged:
                    // Show RangedAnswerView
                    RangedAnswerView(answers: question.answers, submit: answered(with:))
                }
            }
            // .id(questionIndex)
            // IMPORTANT: Add .id(questionIndex) to the Group
            //   - This forces SwiftUI to treat each question as a NEW view
            //   - Without this, toggles/sliders won't reset between questions!
            
            // NEW TRANSITION
            //  New questions slide in from the right and fade in
            //Old questions slide out to the left and fade out

            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)))
            
            // Hint: Add another Spacer() at the bottom
            Spacer()
        }
        // MARK: - Step 5: Add Navigation Modifiers
        // Hint: Add .padding() to the VStack
        .padding()
        
        // Hint: Add .navigationTitle("Question #\(questionIndex + 1)")
        //   - Shows "Question #1", "Question #2", etc.
        //   - The \(...) syntax embeds a variable in a string
        .navigationTitle("Question #\(questionIndex + 1)")
        
        // Hint: Add .navigationBarTitleDisplayMode(.inline)
        //   - Makes the title small and centered
        .navigationBarTitleDisplayMode(.inline)
        
        // Hint: Add .navigationBarBackButtonHidden(true)
        //   - Prevents going back mid-quiz
        .navigationBarBackButtonHidden(true)
        
        // Hint: Add .navigationDestination(isPresented: $showResults) { }
        //   - When showResults becomes true, navigate to ResultsView
        //   - Inside the closure, create: ResultsView(responses: answersChosen, quizActive: $quizActive)
        .navigationDestination(isPresented: $showResults) {
            ResultsView(responses: answersChosen, quizActive: $quizActive)
        }
    }
    
    
    // MARK: - Step 6: Create the Answer Handler Function
    // Think: "What happens when the user answers a question?"
    
    // Hint: Create a private function called answered(with answers: [Answer])
    //   - Takes an array of Answer (could be 1 or multiple)
    //   - Returns nothing (Void)
    //   - Syntax: private func answered(with answers: [Answer]) { }
    private func answered(with answers: [Answer]) { // with = external parameter label (what callers see), answers = internal parameter name (what you use inside)
        
        // Hint: Inside the function:
        //   1. Append the new answers to answersChosen
        //      - Use +=: answersChosen += answers
        answersChosen += answers
        
        //
        //   2. Check if there are more questions
        if questionIndex + 1 < allQuestions.count {
            //          // More questions exist
            //          // Increment questionIndex by 1
            // NEW ANIMATION
            withAnimation((.easeInOut(duration: 0.4))){
                questionIndex += 1
            }
        } else {
            //          // That was the last question
            //          // Set showResults to true
            showResults = true
        }
    }
}

// MARK: - Preview
// Hint: Wrap in NavigationStack because this view uses navigation
// Hint: Use .constant(true) for the binding since preview doesn't have a real binding
#Preview {
     NavigationStack {
         QuestionView(quizActive: .constant(true))
     }
}
