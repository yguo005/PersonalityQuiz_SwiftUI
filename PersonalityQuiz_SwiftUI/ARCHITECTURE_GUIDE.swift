//
//  ARCHITECTURE_GUIDE.swift
//  How the Personality Quiz Works
//

/*

┌─────────────────────────────────────────────────────────────┐
│                     DATA FLOW DIAGRAM                        │
└─────────────────────────────────────────────────────────────┘

1. USER TAPS "BEGIN"
   ↓
2. IntroductionView sets quizActive = true
   ↓
3. NavigationStack pushes QuestionView
   ↓
4. QuestionView reads allQuestions[0]
   ↓
5. Shows SingleAnswerView (because question.type == .single)
   ↓
6. USER TAPS AN ANSWER
   ↓
7. SingleAnswerView calls choose([answer])
   ↓
8. QuestionView.answered(with:) runs:
   - Saves answer
   - Increments questionIndex
   ↓
9. SwiftUI re-renders (body runs again)
   ↓
10. QuestionView reads allQuestions[1]
    ↓
11. Shows MultipleAnswerView (because question.type == .multiple)
    ↓
    ... repeats for all questions ...
    ↓
12. Last question answered → showResults = true
    ↓
13. NavigationStack pushes ResultsView
    ↓
14. ResultsView counts animal votes
    ↓
15. Shows winner
    ↓
16. USER TAPS "DONE"
    ↓
17. ResultsView sets quizActive = false
    ↓
18. NavigationStack pops EVERYTHING
    ↓
19. Back at IntroductionView (ready for next player)


┌─────────────────────────────────────────────────────────────┐
│                   FILE RESPONSIBILITIES                      │
└─────────────────────────────────────────────────────────────┘

PersonalityQuiz_SwiftUIApp.swift
  └─ Entry point: Shows IntroductionView

IntroductionView.swift
  └─ Owns quizActive boolean
  └─ Navigates to QuestionView

Models.swift
  └─ Defines data structures (Question, Answer, AnimalType)
  └─ Contains allQuestions array

QuestionView.swift
  └─ Owns questionIndex and answersChosen
  └─ Decides which answer interface to show
  └─ Navigates to ResultsView

SingleAnswerView.swift
  └─ Shows buttons for single-choice questions

MultipleAnswerView.swift
  └─ Shows toggles for multiple-choice questions

RangedAnswerView.swift
  └─ Shows slider for range questions

ResultsView.swift
  └─ Calculates winner
  └─ Displays result
  └─ Resets navigation


┌─────────────────────────────────────────────────────────────┐
│              KEY SWIFT/SWIFTUI CONCEPTS USED                 │
└─────────────────────────────────────────────────────────────┘

1. STRUCT vs CLASS
   - struct = value type (copied)
   - class = reference type (shared)
   - SwiftUI views are structs (lightweight, fast)

2. @State
   - Marks data this view OWNS
   - Changing it triggers re-render
   - Like React useState

3. @Binding
   - Marks data this view can READ and WRITE
   - But someone else owns it
   - Like passing a pointer/reference

4. Computed Properties
   private var question: Question { allQuestions[index] }
   - No parameters, returns a value
   - Recalculates when dependencies change

5. VStack / HStack / Spacer
   - Layout containers (no Auto Layout!)
   - VStack = vertical
   - HStack = horizontal
   - Spacer = flexible empty space

6. Modifiers
   .font(.largeTitle)
   .padding()
   - Chain onto views to style them
   - Each returns a modified view

7. ForEach
   ForEach(items) { item in ... }
   - Like a for-loop, but builds UI
   - Needs id: to identify each item

8. Closures (Callbacks)
   let choose: ([Answer]) -> Void
   - Functions as parameters
   - Like lambdas in Java/Python

9. Enum with Raw Values
   enum Animal: Character { case lion = "🦁" }
   - Each case stores a value
   - Access with .rawValue

10. Dictionary Default Subscript
    counts[key, default: 0] += 1
    - If key doesn't exist, use 0
    - Avoids checking "is key present?"


┌─────────────────────────────────────────────────────────────┐
│                  THINKING CHECKLIST                          │
└─────────────────────────────────────────────────────────────┘

When building a SwiftUI view, ask:

1. What DATA does this view need?
   → Define properties (let for passed-in, @State for owned)

2. What does this view LOOK LIKE?
   → Describe it in body with VStack/HStack/Text/Button

3. Does this view need to REMEMBER anything?
   → Use @State for values that change

4. Does this view need to TALK to its parent?
   → Use @Binding or pass a closure

5. Does layout need to be flexible?
   → Use Spacer() to push things apart

6. Do I need to loop over data to build UI?
   → Use ForEach

7. How do I navigate to another screen?
   → Wrap in NavigationStack, use navigationDestination

8. How do I style things?
   → Chain modifiers: .font(), .padding(), .buttonStyle()


┌─────────────────────────────────────────────────────────────┐
│              COMPARING TO PYTHON/JAVA                        │
└─────────────────────────────────────────────────────────────┘

Python/Java Concept          Swift/SwiftUI Equivalent
──────────────────────────   ─────────────────────────
class                        struct (for views/data)
self.variable                @State var variable
getter method                computed property (var name { })
list comprehension           .filter { }.map { }
lambda / anonymous func      closure { }
enum                         enum (but more powerful)
interface                    protocol
null                         nil (but with Optional wrapper)
for item in list:            ForEach(list) { item in }
<div>...</div>               VStack { ... } / HStack { ... }

*/
