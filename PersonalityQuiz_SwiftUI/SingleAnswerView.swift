//
//  SingleAnswerView.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import SwiftUI

// MARK: - Single-Answer Interface (Pick One Button)
// Think: "Show 4 buttons, tap one, immediately report back"
// This is the SIMPLEST answer view - just buttons!

struct SingleAnswerView: View {
    // MARK: - Step 1: Define Properties
    // Think: "What data does this view need from its parent (QuestionView)?"
    
    // Hint: You need a property for the answers to display
    //   - Type: [Answer] (array of Answer)
    //   - Use 'let' because this view doesn't change it
    //   - Name it: answers
    let answers: [Answer]
    
    // Hint: You need a property for the callback function
    //   - Type: ([Answer]) -> Void (takes array of Answer, returns nothing)
    //   - Use 'let' because this is just a reference to a function
    //   - Name it: choose
    //   - Think: "When user taps, I'll call this function to tell QuestionView"
    let choose: ([Answer]) -> Void
    
    
    //
    // Understanding the type ([Answer]) -> Void:
    // This is the TYPE
    // ([Answer]) -> Void
    
    // This is an actual function that matches that type
    // func answered(with answers: [Answer]) -> Void {
    // implementation
    // }
    
    // QuestionView passes its function to us
    // We store it and call it later
    //
    
    
    // MARK: - Step 2: Build the UI
    var body: some View {
    
        // Hint: Use VStack with spacing: 16
        
        //   - VStack = vertical stack (arranges views top-to-bottom)
        
        
        //   - spacing: 16 = gap between buttons
        VStack(spacing: 16) {
            
            // MARK: - Step 3: Loop Through Answers
            // Think: "I need to create one button for EACH answer"
            // In imperative code, you'd write:
            //   for answer in answers {
            //       addButton(answer.text)
            //   }
            // In SwiftUI, you use ForEach!
            
            // Hint: Use ForEach to loop over the answers array
            //   - Syntax: ForEach(array, id: keyPath) { item in ... }
            //   - First parameter: answers (the array to loop over)
            //   - Second parameter: id: \.text (tell SwiftUI how to identify each item)
            //   - Closure parameter: answer (the current item in the loop)
            //
            // Understanding 'id: \.text':
            //   - SwiftUI needs to track each item uniquely
            //   - \. is "key path" syntax (like "answer.text" but as a reference)
            //   - We're saying "use the .text property as the unique identifier"
            //   - Like React's 'key' prop: <div key={answer.text}>
            ForEach(answers, id: \.text) { answer in
                
                // MARK: - Step 4: Create a Button for Each Answer
                // Think: "For each answer in the loop, create a button showing its text"
                
                // Hint: Create a Button
                //   - Syntax: Button("label") { action }
                //   - Label: answer.text (the text to display)
                //   - Action: Call the choose function with this answer
                //
                // Important: choose expects [Answer] (array), but you have one answer
                //   - Wrap it in brackets: choose([answer])
                //   - Think: [answer] creates an array with one item
                Button(answer.text) {
                    choose([answer])
                }
                // Hint: Add button styling
                //   - .buttonStyle(.bordered) makes it have a border
                //   - .controlSize(.large) makes it bigger
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
    }
}

// MARK: -  Understanding Guide
//
// KEY CONCEPT 1: Callback Functions
// ═══════════════════════════════════════════════════════════════
// The 'choose' property is a FUNCTION that QuestionView gave us.
//
// Think of it like this:
//   - QuestionView says: "Here's my phone number (choose function)"
//   - SingleAnswerView says: "When user taps, I'll call you"
//   - User taps button
//   - SingleAnswerView calls: choose([answer])
//   - QuestionView receives the call and handles it
//
// Compare to other languages:
//   Java:    interface AnswerCallback { void onAnswer(List<Answer> answers); }
//   Python:  def choose(answers: List[Answer]) -> None:
//   JavaScript: const choose = (answers) => { ... }
//
//
// KEY CONCEPT 2: ForEach Loop
// ═══════════════════════════════════════════════════════════════
// ForEach is SwiftUI's way to create multiple views from an array.
//
// Pattern:
//   ForEach(items, id: \.property) { item in
//       // Create view for this item
//   }
//
// Example with numbers:
//   ForEach([1, 2, 3], id: \.self) { number in
//       Text("\(number)")
//   }
//   Creates: Text("1"), Text("2"), Text("3")
//
// Example with answers:
//   ForEach(answers, id: \.text) { answer in
//       Button(answer.text) { ... }
//   }
//   Creates: Button("Steak"), Button("Fish"), Button("Carrots"), Button("Corn")
//
//
// KEY CONCEPT 3: The 'id' Parameter
// ═══════════════════════════════════════════════════════════════
// SwiftUI needs to know: "Which item is which?"
//
// Without id:
//   - SwiftUI can't track items if the array changes
//   - Animations break
//   - Updates are unreliable
//
// With id: \.text:
//   - SwiftUI uses each answer's .text as its identifier
//   - "Steak" is always "Steak", even if array reorders
//
// Key path syntax (\.)
//   \.text means "the .text property"
//   \.self means "the item itself"
//
//
// KEY CONCEPT 4: Why [answer] instead of answer?
// ═══════════════════════════════════════════════════════════════
// Look at the function signature:
//   let choose: ([Answer]) -> Void
//              ↑ expects an ARRAY
//
// But in the loop, we have ONE answer:
//   ForEach(...) { answer in  ← single Answer
//
// Solution: wrap it in brackets
//   choose([answer])
//   ↑ creates an array with one item
//
// Why array? Because other answer views (multiple choice) need to
// send multiple answers. QuestionView expects an array for all cases.
//
//

