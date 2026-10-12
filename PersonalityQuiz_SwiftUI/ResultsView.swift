//
//  ResultsView.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import SwiftUI

// MARK: - Results Screen
// Think: "Tally the answers, show the winner, provide a way back to start"
// This is the FINAL screen - shows which animal personality the user has!

struct ResultsView: View {
    // MARK: - Step 1: Define Properties
    // Think: "What data does this screen need?"
    
    // Hint: You need a property for the responses (all answers collected)
    //   - Type: [Answer] (array of all the answers from the quiz)
    //   - Use 'let' because we're just reading them
    //   - Name it: responses
    let responses: [Answer]
    
    // Hint: You need a @Binding to quizActive
    //   - Type: Bool
    //   - Why @Binding? To reset navigation when user taps "Done"
    //   - When we set this to false, we pop back to IntroductionView
    @Binding var quizActive: Bool
    
    
    // MARK: - Step 2: Create Computed Property to Calculate Winner
    // Think: "Which animal got the most votes?"
    // This is the CORE LOGIC of the results screen!
    
    // Hint: Create a computed property called mostCommonAnswer
    //   - Returns: AnimalType
    //   - Access modifier: private (only this view needs it)
    //   - Syntax: private var mostCommonAnswer: AnimalType { }
    private var mostCommonAnswer: AnimalType{
        // THE ALGORITHM (Dictionary Counting Pattern):
        //
        // Step 1: Create empty dictionary to count votes
        //   - var counts: [AnimalType: Int] = [:]
        //   - Keys = animals (.lion, .cat, etc.)
        //   - Values = how many times each appeared
        var counts: [AnimalType: Int] = [:] //[:] = start empty
        
        //
        // Step 2: Loop through all responses
        //   - for response in responses { }
        //   - For each response, increment its animal's count
        //   - Use: counts[response.type, default: 0] += 1
        //var counts:
        // Understanding "default: 0":
        //   - If .lion doesn't exist in dictionary yet, start at 0
        //   - Then add 1
        //   - Example: counts[.lion, default: 0] += 1
        //     First time: 0 + 1 = 1
        //     Second time: 1 + 1 = 2
        //
        for response in responses {
            counts[response.type, default:0] += 1
        }
        // Step 3: Find the animal with highest count
        //   - Use: counts.max(by: comparison)
        //   - Comparison: { $0.value < $1.value }
        //   - Then get the .key (which is the AnimalType)
        //   - Use ! to force unwrap (safe because responses isn't empty)
        return counts.max{$0.value < $1.value}!.key
    }
    //
    // Understanding max(by:):
    //   - $0 = first pair being compared (e.g., .lion: 2)
    //   - $1 = second pair being compared (e.g., .cat: 1)
    //   - $0.value < $1.value means "return the one with larger value"
    //   - Returns: the dictionary entry with max count
    //   - .key extracts the AnimalType from the (key, value) pair
    
    
    // MARK: - Step 3: Build the UI
    var body: some View {
        // Hint: Use VStack with spacing: 20
        VStack(spacing:20){
            
            // Hint: Add Spacer() at top to center content vertically
            Spacer()
            
            // Hint: Show "You are a..." text
            //   - Text("You are a...")
            //   - .font(.title2)
            Text("You are a...")
                .font(.title2)
            
            // Hint: Show the emoji (BIG!)
            //   - Get emoji from mostCommonAnswer.rawValue
            //   - Need to convert Character to String: String(mostCommonAnswer.rawValue)
            //   - Add exclamation mark: "\(String(...))!"
            //   - Make it huge: .font(.system(size: 80))
            Text("\(String(mostCommonAnswer.rawValue))!")
                .font(.system(size:80))
            //
            // Understanding string interpolation with conversion:
            //   mostCommonAnswer.rawValue is Character ('🦁')
            //   String(...) converts to String
            //   \(...) embeds in string
            //   Result: "🦁!"
            
            // Hint: Show the personality description
            //   - Text(mostCommonAnswer.definition)
            //   - .multilineTextAlignment(.center)
            //   - .foregroundStyle(.secondary) for gray color
            Text(mostCommonAnswer.definition)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            
            // Hint: Add Spacer() at bottom
            Spacer()
        }
        // MARK: - Step 4: Add Navigation Styling
        .padding(.horizontal, 40)
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        //   - Prevents going back mid-results
        
        // Hint: Add .toolbar { } for the Done button
        //   - Inside toolbar closure, create a Button("Done") { }
        //   - Action: Set quizActive = false
        //   - This dismisses the entire quiz navigation stack!
        .toolbar{
            // NEW: Add ShareLink to toolbar
            ToolbarItem(placement: .topBarTrailing){// puts Done button on the RIGHT
                Button("Done"){
                    quizActive = false
                }
            }
            ToolbarItem(placement: .topBarLeading){// puts ShareLink on the LEFT
                ShareLink(
                    item: "I got \(String(mostCommonAnswer.rawValue))! \(mostCommonAnswer.definition)",
                    subject: Text("My Personality Quiz Result"),
                    message: Text("Check out what I got!")
                )
            }
        }
    }
    
    
}

// MARK: -Understanding Guide
//
// KEY CONCEPT 1: Dictionary Counting Pattern
// ═══════════════════════════════════════════════════════════════
// This is one of the MOST COMMON patterns in programming!
// Used for tallying, grouping, frequency counting, etc.
//
// THE PATTERN:
//   1. Create empty dictionary: var counts: [Key: Int] = [:]
//   2. Loop and count: counts[item, default: 0] += 1
//   3. Find max: counts.max(by: { $0.value < $1.value })
//
// EXAMPLE WALKTHROUGH:
//   responses = [
//       Answer(..., type: .lion),
//       Answer(..., type: .cat),
//       Answer(..., type: .lion),
//   ]
//
//   Step 1: counts = [:]
//
//   Step 2: Loop
//     First response (.lion):
//       counts[.lion, default: 0] += 1
//       counts = [.lion: 1]
//
//     Second response (.cat):
//       counts[.cat, default: 0] += 1
//       counts = [.lion: 1, .cat: 1]
//
//     Third response (.lion):
//       counts[.lion, default: 0] += 1
//       counts = [.lion: 2, .cat: 1]
//
//   Step 3: Find max
//     Compare .lion: 2 vs .cat: 1
//     Winner: .lion (value 2 > value 1)
//     Return: .lion
//
//
// KEY CONCEPT 2: Dictionary Default Subscript
// ═══════════════════════════════════════════════════════════════
// Why use 'default:'?
//
// WITHOUT default (causes error):
//   var counts: [AnimalType: Int] = [:]
//   counts[.lion] += 1  // ❌ ERROR! .lion doesn't exist yet
//
// WITH default (safe):
//   var counts: [AnimalType: Int] = [:]
//   counts[.lion, default: 0] += 1  // ✅ If not exists, use 0
//
// How it works:
//   counts[.lion, default: 0]
//   ↓
//   "Does .lion exist in dictionary?"
//   NO  → Use default value (0) → 0 + 1 = 1 → Store .lion: 1
//   YES → Use existing value (e.g., 1) → 1 + 1 = 2 → Update to .lion: 2
//
//
// KEY CONCEPT 3: max(by:) Function
// ═══════════════════════════════════════════════════════════════
// Finds the maximum element using custom comparison.
//
// SYNTAX:
//   collection.max(by: comparisonClosure)
//
// EXAMPLE:
//   let numbers = [3, 1, 4, 1, 5]
//   numbers.max(by: { $0 < $1 })  // Returns 5
//
// For dictionaries:
//   let counts = [.lion: 2, .cat: 1, .rabbit: 3]
//   counts.max(by: { $0.value < $1.value })
//   ↓
//   Compares pairs:
//     (.lion: 2) vs (.cat: 1) → keep (.lion: 2)
//     (.lion: 2) vs (.rabbit: 3) → keep (.rabbit: 3)
//   Returns: (.rabbit, 3)
//   Extract key with .key → .rabbit
//
// Understanding $0 and $1:
//   $0 = first item being compared
//   $1 = second item being compared
//   $0.value = the Int count from first pair
//   $1.value = the Int count from second pair
//
//
// KEY CONCEPT 4: Force Unwrapping (!)
// ═══════════════════════════════════════════════════════════════
// Why the ! in .max(...)!.key?
//
// .max(...) returns Optional:
//   let result = counts.max(...)
//   // Type: (key: AnimalType, value: Int)? ← Optional!
//
// Why Optional? Because dictionary might be empty!
//   let empty: [AnimalType: Int] = [:]
//   empty.max(...)  // Returns nil
//
// In our case, it's SAFE to force unwrap because:
//   - responses is never empty (user answered questions)
//   - If responses has items, counts has items
//   - If counts has items, max() returns non-nil
//
// return counts.max(...)!.key
//         ↑ Returns Optional   ↑ Force unwrap ↑ Get AnimalType
//
//
// KEY CONCEPT 5: Accessing Raw Values and Computed Properties
// ═══════════════════════════════════════════════════════════════
// Remember from Models.swift:
//   enum AnimalType: Character {
//       case lion = "🦁"  ← raw value
//       
//       var definition: String {  ← computed property
//           switch self {
//               case .lion: return "Bold and social..."
//           }
//       }
//   }
//
// Accessing in ResultsView:
//   mostCommonAnswer.rawValue      // Character '🦁'
//   mostCommonAnswer.definition    // String "Bold and social..."
//
// Converting for display:
//   String(mostCommonAnswer.rawValue)  // "🦁" (String)
//
//
// KEY CONCEPT 6: Navigation Reset with @Binding
// ═══════════════════════════════════════════════════════════════
// How does the "Done" button work?
//
// THE FLOW:
//   1. IntroductionView owns quizActive: @State var quizActive = false
//   2. User taps "Begin" → quizActive = true
//   3. NavigationDestination pushes QuestionView
//   4. QuestionView passes binding down: QuestionView(quizActive: $quizActive)
//   5. QuestionView navigates to ResultsView: ResultsView(..., quizActive: $quizActive)
//   6. User taps "Done" → quizActive = false
//   7. IntroductionView sees quizActive changed to false
//   8. NavigationDestination dismisses
//   9. Entire stack pops → back to IntroductionView!
//
// Think: @Binding creates a "thread" back to the original value.
// Pull the thread (set to false) and the whole stack collapses!
//
//
// COMPARE TO OTHER LANGUAGES:
// ═══════════════════════════════════════════════════════════════
//
// Python (dictionary counting):
//   counts = {}
//   for response in responses:
//       animal = response.type
//       counts[animal] = counts.get(animal, 0) + 1
//   most_common = max(counts, key=counts.get)
//
// Java (dictionary counting):
//   Map<AnimalType, Integer> counts = new HashMap<>();
//   for (Answer response : responses) {
//       counts.merge(response.type, 1, Integer::sum);
//   }
//   AnimalType mostCommon = counts.entrySet().stream()
//       .max(Map.Entry.comparingByValue())
//       .get().getKey();
//
// Swift (dictionary counting):
//   var counts: [AnimalType: Int] = [:]
//   for response in responses {
//       counts[response.type, default: 0] += 1
//   }
//   let mostCommon = counts.max { $0.value < $1.value }!.key
//
//
