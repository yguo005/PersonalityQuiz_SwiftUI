//
//  RangedAnswerView.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import SwiftUI

// MARK: - Ranged Answer Interface (Slider)
// Think: "Show a slider from 0.0 to 1.0, convert position to answer index"
// This is DIFFERENT from the other two views because:
//   1. User drags a slider instead of tapping
//   2. We need to do MATH to convert slider position (0.0-1.0) to an answer index (0-3)
//   3. We show labels at both ends of the slider

struct RangedAnswerView: View {
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
    //   - Name it: submit
    let submit: ([Answer]) -> Void
    
    
    // MARK: - Step 2: Create State to Track Slider Position
    // Think: "I need to remember where the slider is positioned"
    
    // Hint: Create a @State property called value
    //   - Type: Double (sliders use decimal numbers)
    //   - Initial value: 0.5 (start in the middle)
    //   - Range: This will go from 0.0 (left) to 1.0 (right)
    //   - Why @State? Because the slider CHANGES this value as user drags
    //
    // Understanding the slider range:
    //   - 0.0 = far left (first answer)
    //   - 0.5 = middle
    //   - 1.0 = far right (last answer)
    
    @State private var value = 0.5
    
    
    // MARK: - Step 3: Build the UI
    
    var body: some View {
        
        
        // Hint: Use VStack with spacing: 16
        VStack(spacing: 16) {
            
            // MARK: - Step 4: Create the Slider
            
            // Think: "Create a slider that the user can drag"
            
            // Hint: Create a Slider
            //   - Syntax: Slider(value: $binding)
            //   - value: $value (bind to our @State property)
            //   - The slider automatically ranges from 0.0 to 1.0 by default
            //
            // Understanding the binding ($):
            //   - $value creates a two-way connection
            //   - When user drags slider, value automatically updates
            //   - Like Toggle, Slider needs to read AND write the value
            Slider(value: $value)
            
            
            // MARK: - Step 5: Add Labels Below the Slider
            // Think: "Show what the two ends represent"
            //
            // Visual:
            //   ━━━━━━●━━━━━━  (slider)
            //   I dislike    I love
            //   (left)       (right)
            
            // Hint: Create an HStack to show labels side-by-side
            
            // Hint: Show the first answer's text on the left
            //   - Use: answers.first?.text
            //   - The ? is because .first might be nil (empty array)
            //   - Use ?? "" to provide a fallback (empty string if nil)
            HStack {
                Text(answers.first?.text ?? "")
                
                // Hint: Add a Spacer() to push labels apart
                Spacer()
                
                // Hint: Show the last answer's text on the right
                //   - Use: answers.last?.text ?? ""
                Text(answers.last?.text ?? "")}
            
            // Hint: Style the HStack
            //   - .font(.footnote) makes text smaller
            .font(.footnote)
            //   - .foregroundStyle(.secondary) makes it gray/subtle
            .foregroundStyle(.secondary)
            
            
            // MARK: - Step 6: Create the Submit Button
            // Think: "After user positions slider, they tap Submit"
            
            // Hint: Create a Button with label "Submit Answer"
            Button("Submit Answer"){
                
                
                
                // MARK: - Step 7: Convert Slider Position to Answer Index (THE MATH!)
                // Think: "How do I map 0.0-1.0 to 0-3?"
                //
                // THE CHALLENGE:
                //   Slider gives us: value (0.0 to 1.0)
                //   We need: index (0, 1, 2, or 3)
                //
                // THE FORMULA:
                //   index = value × (number of answers - 1), then round
                //
                // WHY "number of answers - 1"?
                //   Because indices start at 0!
                //   4 answers → indices are 0, 1, 2, 3 (highest is 3, not 4)
                //
                // EXAMPLE with 4 answers:
                //   value = 0.0 → 0.0 × 3 = 0.0 → round to 0 → answers[0]
                //   value = 0.3 → 0.3 × 3 = 0.9 → round to 1 → answers[1]
                //   value = 0.6 → 0.6 × 3 = 1.8 → round to 2 → answers[2]
                //   value = 1.0 → 1.0 × 3 = 3.0 → round to 3 → answers[3]
                //
                // STEP-BY-STEP:
                //   1. Get the highest index: answers.count - 1
                //   2. Multiply: value * (answers.count - 1)
                //   3. Round to nearest integer: round(...)
                //   4. Convert to Int: Int(...)
                //   5. Use it to get the answer: answers[index]
                //
                // Hint: Create a constant called index
                //   - Formula: Int(round(value * Double(answers.count - 1)))
                //   - Why Double()? Because value is Double, need to match types
                let index = Int(round(value * Double(answers.count - 1)))
                //
                // Hint: Call submit with the chosen answer
                //   - Use: submit([answers[index]])
                //   - Remember: Wrap in array because submit expects [Answer]
                submit([answers[index]])
            }
            
            
            // Hint: Add button styling
            //   - .buttonStyle(.borderedProminent)
            //   - .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
        }
    }
}
    
    // MARK: -  Understanding Guide
    //
    // KEY CONCEPT 1: Slider Control
    // ═══════════════════════════════════════════════════════════════
    // What is a Slider?
    //   - A UI control for selecting a value in a range
    //   - User drags a knob left/right
    //   - Returns a continuous value (not discrete like buttons)
    //
    // SwiftUI Slider:
    //   Slider(value: $value)
    //   - Default range: 0.0 to 1.0
    //   - Can customize: Slider(value: $value, in: 0...100)
    //   - We use default because 0.0-1.0 is perfect for our math
    //
    // Compare to other frameworks:
    //   - HTML: <input type="range">
    //   - UIKit: UISlider
    //   - Android: SeekBar
    //
    //
    // KEY CONCEPT 2: Optional Chaining (?.)
    // ═══════════════════════════════════════════════════════════════
    // What is answers.first?
    //
    // .first is an optional property on arrays:
    //   let numbers = [1, 2, 3]
    //   numbers.first  // Optional(1)
    //
    //   let empty: [Int] = []
    //   empty.first    // nil
    //
    // Why optional? Because the array might be empty!
    //
    // Accessing with optional chaining:
    //   answers.first?.text
    //   ↑ If first is nil, the whole expression becomes nil
    //
    // Providing a fallback with ??:
    //   answers.first?.text ?? ""
    //   ↑ If nil, use "" instead
    //
    // Compare to other languages:
    //   Python:  answers[0] if answers else ""
    //   Java:    answers.isEmpty() ? "" : answers.get(0).getText()
    //
    //
    // KEY CONCEPT 3: The Math (Mapping Continuous to Discrete)
    // ═══════════════════════════════════════════════════════════════
    // Problem: Convert continuous range (0.0-1.0) to discrete indices (0-3)
    //
    // FORMULA:
    //   index = round(value × (count - 1))
    //
    // Why this works:
    //   value range:  [0.0 .......... 0.5 .......... 1.0]
    //   multiply by 3: [0.0 .......... 1.5 .......... 3.0]
    //   round:         [0   .......... 2   .......... 3  ]
    //   indices:       [0,   1,        2,        3       ]
    //
    // Visualization with 4 answers:
    //   Slider:  |----●----|----●----|----●----|
    //   Values:  0.0      0.33     0.67      1.0
    //   ×3:      0.0      1.0      2.0       3.0
    //   Round:   0        1        2         3
    //   Answer:  "I dislike" "nervous" "notice" "love"
    //
    // Edge cases:
    //   value = 0.0   → 0.0 × 3 = 0.0  → round(0.0) = 0 ✓
    //   value = 0.1   → 0.1 × 3 = 0.3  → round(0.3) = 0 ✓
    //   value = 0.2   → 0.2 × 3 = 0.6  → round(0.6) = 1 ✓
    //   value = 0.5   → 0.5 × 3 = 1.5  → round(1.5) = 2 ✓
    //   value = 1.0   → 1.0 × 3 = 3.0  → round(3.0) = 3 ✓
    //
    //
    // KEY CONCEPT 4: Type Conversion
    // ═══════════════════════════════════════════════════════════════
    // The conversion chain:
    //
    //   value                    // Type: Double (0.5)
    //   ↓
    //   answers.count - 1        // Type: Int (3)
    //   ↓
    //   Double(answers.count - 1)  // Type: Double (3.0)
    //   ↓
    //   value * Double(answers.count - 1)  // Type: Double (1.5)
    //   ↓
    //   round(...)               // Type: Double (2.0)
    //   ↓
    //   Int(round(...))          // Type: Int (2)
    //
    // Why all these conversions?
    //   - Can't multiply Double × Int directly (type mismatch)
    //   - round() returns Double (even though it's a whole number)
    //   - Need Int for array index
    //
    // Compare to other languages:
    //   Python: Automatic conversion (1.5 * 3 works)
    //   Java:   Explicit casting required (like Swift)
    //
    //
    // KEY CONCEPT 5: Understanding round()
    // ═══════════════════════════════════════════════════════════════
    // round() rounds to nearest integer:
    //
    //   round(0.0) = 0.0
    //   round(0.4) = 0.0  (closer to 0 than 1)
    //   round(0.5) = 0.0  (ties round to even - banker's rounding)
    //   round(0.6) = 1.0  (closer to 1)
    //   round(1.5) = 2.0
    //   round(2.9) = 3.0
    //
    // Alternatives (not used here, but good to know):
    //   floor(1.9) = 1.0  (always round down)
    //   ceil(1.1) = 2.0   (always round up)
    //
    //
    // KEY CONCEPT 6: Why Start at 0.5?
    // ═══════════════════════════════════════════════════════════════
    // @State private var value = 0.5
    //
    // Why middle instead of 0.0 (left)?
    //   - Neutral starting position
    //   - Doesn't bias toward any answer
    //   - User sees slider is adjustable
    //   - Common UX pattern for "neutral" or "moderate" default
    //
    // With 4 answers and value = 0.5:
    //   0.5 × 3 = 1.5 → round to 2 → answers[2] (third answer)
    //   This is usually the "moderate" answer
    //
    //
    // REAL-WORLD EXAMPLE:
    // ═══════════════════════════════════════════════════════════════
    // Question: "How much do you enjoy car rides?"
    // Answers:
    //   [0] "I dislike them"
    //   [1] "I get a little nervous"
    //   [2] "I barely notice them"
    //   [3] "I love them"
    //
    // User drags slider to 75% (value = 0.75):
    //   0.75 × 3 = 2.25
    //   round(2.25) = 2
    //   answers[2] = "I barely notice them"
    //
    // User drags slider to far right (value = 1.0):
    //   1.0 × 3 = 3.0
    //   round(3.0) = 3
    //   answers[3] = "I love them"
    //
    //
