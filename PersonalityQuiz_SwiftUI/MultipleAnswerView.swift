//
//  MultipleAnswerView.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import SwiftUI

// MARK: - Multiple-Answer Interface (Pick Many Toggles)
// Think: "Show toggles, let user flip them on/off, submit when done"
// This is MORE COMPLEX than SingleAnswerView because:
//   1. We need to track which toggles are on/off (@State)
//   2. User can select 0, 1, 2, 3, or all 4 answers
//   3. We need a Submit button (unlike SingleAnswerView which submits immediately)

struct MultipleAnswerView: View {
    // MARK: - Step 1: Define Properties
    // Think: "What data comes from the parent (QuestionView)?"
    
    // Hint: You need a property for the answers to display
    //   - Type: [Answer]
    //   - Use 'let' because this view doesn't change it
    //   - Name it: answers
    let answers: [Answer]
    
    // Hint: You need a property for the callback function
    //   - Type: ([Answer]) -> Void
    //   - Use 'let' because it's just a reference
    //   - Name it: submit (not 'choose' like SingleAnswerView, to show it's different)
    //   - Think: "When user taps Submit, I'll call this with ALL selected answers"
    let submit: ([Answer]) -> Void
    
    
    // MARK: - Step 2: Create State to Track Toggle Values
    // Think: "I need to remember which toggles are on/off"
    // This is the KEY difference from SingleAnswerView!
    
    // Hint: Create a @State property called isChosen
    //   - Type: [Bool] (array of booleans)
    //   - Initial value: [false, false, false, false] (all toggles start OFF)
    //   - Why 4? Because we have 4 answers
    //   - Why @State? Because this view OWNS this data and it CHANGES
    @State private var isChosen = [false, false, false, false]
    //
    // Understanding the mapping:
    
    //   isChosen[0] = true/false for first toggle (Swimming)
    
    //   isChosen[1] = true/false for second toggle (Sleeping)
    
    //   isChosen[2] = true/false for third toggle (Cuddling)
    
    //   isChosen[3] = true/false for fourth toggle (Eating)
    
    
    
    
    // MARK: - Step 3: Build the UI
    
    
    var body: some View {
    
        // Hint: Use VStack with spacing: 16
        VStack(spacing: 16) {
            
            // MARK: - Step 4: Loop Through Answers
            // Think: "I need BOTH the answer AND its index"
            // Why index? To bind each toggle to the correct isChosen[i]
            
            // NEW CONCEPT: ForEach with indices instead of items!
            //
            // Instead of: ForEach(answers, id: \.text) { answer in ... }
            // We use:     ForEach(answers.indices, id: \.self) { i in ... }
            //
            // Understanding answers.indices:
            //   - If answers has 4 items, answers.indices = [0, 1, 2, 3]
            //   - We loop over INDEX NUMBERS, not the answers themselves
            //   - Inside the loop, 'i' is 0, then 1, then 2, then 3
            //   - We can use 'i' to access both answers[i] and isChosen[i]
            //
            // Hint: Create ForEach(answers.indices, id: \.self) { i in ... }
            //   - answers.indices = the range [0, 1, 2, 3]
            //   - id: \.self = use the number itself as the id
            //   - i = the loop variable (0, 1, 2, 3)
            ForEach(answers.indices, id: \.self) { i in
                
                
                
                
                // MARK: - Step 5: Create a Toggle for Each Answer
                // Think: "Create a toggle showing the answer text, bound to isChosen[i]"
                
                // Hint: Create a Toggle
                //   - Syntax: Toggle("label", isOn: $binding)
                //   - Label: answers[i].text (access answer using index 'i')
                //   - isOn: $isChosen[i] (bind to the boolean at index 'i')
                //
                // Understanding the binding ($):
                //   - $isChosen[i] creates a two-way connection
                //   - When toggle flips, isChosen[i] automatically updates
                //   - When isChosen[i] changes, toggle automatically updates
                //   - Like React's useState: [value, setValue]
                Toggle(answers[i].text, isOn: $isChosen[i])
            }
            
            // MARK: - Step 6: Create the Submit Button
            // Think: "After user selects toggles, they tap Submit"
            
            // Hint: Create a Button with label "Submit Answer"
            //   - Place it OUTSIDE the ForEach (but inside VStack)
            //   - Action: Collect selected answers and call submit()
            Button("Submit Answer"){
                
                
                // MARK: - Step 7: Collect Selected Answers (The Tricky Part!)
                // Think: "Convert [true, false, true, false] into [Answer, Answer]"
                //
                // Example scenario:
                //   isChosen = [false, true, false, true]
                //   This means: user selected answers at index 1 and 3
                //   We need to send: [answers[1], answers[3]]
                //
                // Strategy: Use FILTER and MAP (functional programming!)
                //
                // Step 1: Get indices where isChosen is true
                //   - Use: answers.indices.filter { isChosen[$0] }
                //   - This filters [0, 1, 2, 3] to only indices where isChosen is true
                //   - Result: [1, 3]
                //   - Understanding $0: It's the shorthand for "the current item"
                
                //
                // Step 2: Map indices to actual Answer objects
                //   - Use: chosenIndices.map { answers[$0] }
                //   - This transforms [1, 3] to [answers[1], answers[3]]
                //   - Result: Array of actual Answer objects
                
                //
                // Step 3: Call submit with the chosen answers
                //   - Use: submit(chosenAnswers)
                
                //
                // Hint: You can do this in 3 lines or 1 line (chaining)
                // 3-line version:
                //   let chosenIndices = answers.indices.filter { isChosen[$0] }
                let chosenIndices = answers.indices.filter{isChosen[$0]}
                
                //   let chosenAnswers = chosenIndices.map { answers[$0] }
                let chosenAnswers = chosenIndices.map{answers[$0]}
                //   submit(chosenAnswers)
                submit(chosenAnswers)
            }
            // 1-line version:
            //   submit(answers.indices.filter { isChosen[$0] }.map { answers[$0] })
            
            // Hint: Add button styling
            //   - .buttonStyle(.borderedProminent) makes it filled/prominent
            .buttonStyle(.borderedProminent)
            //   - .controlSize(.large) makes it bigger
            .controlSize(.large)
        }
    }
}

// MARK: -  Understanding Guide
//
// KEY CONCEPT 1: ForEach with Indices
// ═══════════════════════════════════════════════════════════════
// Why do we use indices instead of items directly?
//
// SingleAnswerView approach (direct items):
//   ForEach(answers, id: \.text) { answer in
//       Button(answer.text) { ... }
//   }
//   Works because we only need the answer itself
//
// MultipleAnswerView approach (indices):
//   ForEach(answers.indices, id: \.self) { i in
//       Toggle(answers[i].text, isOn: $isChosen[i])
//   }
//   Need indices because we must access BOTH arrays:
//     - answers[i] for the text
//     - isChosen[i] for the toggle state
//
// Think of it like:
//   for i in range(len(answers)):  # Python
//       toggle = Toggle(answers[i].text, isChosen[i])
//
//
// KEY CONCEPT 2: Bindings ($)
// ═══════════════════════════════════════════════════════════════
// What is $isChosen[i]?
//
// isChosen[i]   = READ the value (true or false)
// $isChosen[i]  = TWO-WAY binding (read AND write)
//
// Example:
//   @State var isOn = false
//   
//   isOn          // Just reads: false
//   $isOn         // Binding: Toggle can read AND change it
//   
//   Toggle("Label", isOn: $isOn)  // Toggle controls the value
//
// When you use $ with an array:
//   @State var flags = [false, true, false]
//   
//   flags[1]      // Reads: true
//   $flags[1]     // Binding to the second element
//   
//   Toggle("Label", isOn: $flags[1])  // Toggle controls flags[1]
//
//
// KEY CONCEPT 3: Filter and Map
// ═══════════════════════════════════════════════════════════════
// These are fundamental functional programming operations.
//
// FILTER: Keep only items that match a condition
//   [0, 1, 2, 3].filter { $0 > 1 }  →  [2, 3]
//   Keep only numbers greater than 1
//
// MAP: Transform each item
//   [1, 2, 3].map { $0 * 2 }  →  [2, 4, 6]
//   Double each number
//
// COMBINED (our use case):
//   Step 1: Filter indices where isChosen is true
//     [0, 1, 2, 3].filter { isChosen[$0] }
//     If isChosen = [false, true, false, true]
//     Result: [1, 3]
//   
//   Step 2: Map indices to answers
//     [1, 3].map { answers[$0] }
//     Result: [answers[1], answers[3]]
//
// Python equivalent:
//   chosen = [answers[i] for i in range(len(answers)) if isChosen[i]]
//
// Java equivalent:
//   List<Answer> chosen = IntStream.range(0, answers.size())
//       .filter(i -> isChosen.get(i))
//       .mapToObj(answers::get)
//       .collect(Collectors.toList());
//
//
// KEY CONCEPT 4: Understanding $0
// ═══════════════════════════════════════════════════════════════
// $0 is shorthand for "the first parameter in a closure"
//
// Verbose version:
//   .filter { index in isChosen[index] }
//
// Shorthand version:
//   .filter { isChosen[$0] }
//
// Both mean the same thing! $0 = the current item being filtered
//
// More examples:
//   [1, 2, 3].map { $0 * 2 }        // Same as: .map { num in num * 2 }
//   [1, 2, 3].filter { $0 > 1 }     // Same as: .filter { num in num > 1 }
//
//
// KEY CONCEPT 5: Why [false, false, false, false]?
// ═══════════════════════════════════════════════════════════════
// We need one boolean for each answer.
//
// If we have 4 answers:
//   answers = [Answer("Swimming"), Answer("Sleeping"), ...]
//   isChosen = [false, false, false, false]
//
// Position mapping:
//   answers[0] = "Swimming"  ↔  isChosen[0] = false (toggle off)
//   answers[1] = "Sleeping"  ↔  isChosen[1] = false (toggle off)
//   answers[2] = "Cuddling"  ↔  isChosen[2] = false (toggle off)
//   answers[3] = "Eating"    ↔  isChosen[3] = false (toggle off)
//
// When user flips second toggle:
//   isChosen becomes [false, true, false, false]
//
// When user flips third toggle too:
//   isChosen becomes [false, true, true, false]
//
// When they submit:
//   Filter to indices: [1, 2]
//   Map to answers: [answers[1], answers[2]]
//   Submit: ["Sleeping", "Cuddling"]
//
//
