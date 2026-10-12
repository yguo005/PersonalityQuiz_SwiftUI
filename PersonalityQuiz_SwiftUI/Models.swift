//
//  Models.swift
//  PersonalityQuiz_SwiftUI
//
//  Created by Emma Guo on 10/10/26.
//

import Foundation

// MARK: - Step 1: Define the Question Types
// Think: "What kinds of questions will I ask?"
// Hint: Create an enum called ResponseType with three cases:
enum ResponseType {
    //   - single (Pick one with buttons)
    case single
    //   - multiple (Pick many with toggles)
    case multiple
    //   - ranged (Slider)
    case ranged
}

// MARK: - Step 2: Define What a Question Contains
// Think: "A question needs text, a type, and possible answers"
// Hint: Create a struct called Question with three properties:
struct Question{
    //   - text: String (the question text like "Which food do you like?")
    let text: String
    //   - type: ResponseType (single, multiple, or ranged)
    let type: ResponseType
    //   - answers: [Answer] (an array of possible answers)
    let answers: [Answer]
    
}

// MARK: - Step 3: Define What an Answer Contains
// Think: "Each answer has text AND secretly votes for an animal"

// Hint: Create a struct called Answer with two properties:
struct Answer {
    //   - text: String (like "Steak")
    let text: String
    //   - type: AnimalType (which animal this answer votes for)
    let type: AnimalType
}

// MARK: - Step 4: Define the Possible Results
// Think: "What animals can you be? Use an enum because you're ONE animal, not multiple"
// Hint: Create an enum called AnimalType with Character as the raw value type
enum AnimalType: Character {
    //   - Four cases: lion, cat, rabbit, turtle
    //   - Each case should have an emoji as its raw value (🦁, 🐱, 🐰, 🐢)
//    case lion = "🦁"
//    case cat = "🐱"
//    case rabbit = "🐰"
//    case turtle = "🐢"
//
    
    // NEW
    case gryffindor = "🦁"
    case hufflepuff = "🦡"
    case ravenclaw = "🦅"
    case slytherin = "🐍"
    
    //   - Add a computed property called 'definition' that returns String
    //   - Use a switch statement to return different personality descriptions for each animal
    var definition: String {
//        // Example personality descriptions:
//        //   Lion: "Bold and social, you walk into a room and make it warmer..."
//        switch self {
//        case .lion:
//            return "Bold and social, you walk into a room and make it warmer. You do your best work surrounded by your favorite people."
//        case .cat:
//            return "Independent with a playful streak, you pick your moments — and when you show up, it is entirely on your own terms."
//        case .rabbit:
//            return "Gentle, quick, and endlessly curious, you bring soft energy everywhere you go and never quite sit still."
//        case .turtle:
//            return "Calm and thoughtful, you take the long view. You would rather do it right than do it fast — and it shows."
            
        // NEW
        switch self {
        case .gryffindor:
            return "Brave and daring, you stand up for what's right and never back down from a challenge. Your courage inspires others."
        case .hufflepuff:
            return "Loyal and hardworking, you value friendship and fairness above all. You bring people together with your kindness."
        case .ravenclaw:
            return "Clever and creative, you seek knowledge and think outside the box. Your wit and wisdom set you apart."
        case .slytherin:
            return "Ambitious and cunning, you know what you want and how to get it. Your determination leads you to success."
        }
    }
    
}

// MARK: - Step 5: Create the Actual Quiz Questions
// Think: "This is like a JSON file of quiz data, but in Swift"
// Hint: Create a constant called allQuestions that is an array of Question structs
let allQuestions: [Question] = [
    // Question 1: Single choice
//    Question(
//    //   - Text: "Which food do you like the most?"
//    text: "Which food do you like the most?",
//    //   - Type: .single
//    type: .single,
//    //   - Answers: Steak (lion), Fish (cat), Carrots (rabbit), Corn (turtle)
//    answers: [
//        Answer (text: "Steak", type: .lion),
//        Answer(text: "Fish", type: .cat),
//        Answer(text: "Carrots", type: .rabbit),
//        Answer(text: "Corn", type: .turtle),
//    ]
//    ),
//    // Question 2: Multiple choice
//    //   - Text: "Which of the following activities do you enjoy?"
//    //   - Type: .multiple
//    //   - Answers: Swimming (turtle), Sleeping (cat), Cuddling (rabbit), Eating (lion)
//    Question (
//        text: "Which of the following activities do you enjoy?",
//        type: .multiple,
//        answers: [
//            Answer(text: "Swimming", type: .turtle),
//            Answer(text: "Sleeping", type: .cat),
//            Answer(text: "Cuddling", type: .rabbit),
//            Answer(text: "Eating", type: .lion)
//        ]
//    ),
//    // Question 3: Range (slider)
//    //   - Text: "How much do you enjoy car rides?"
//    //   - Type: .ranged
//    //   - Answers: "I dislike them" (cat), "I get a little nervous" (rabbit),
//    //              "I barely notice them" (turtle), "I love them" (lion)
//    Question(text: "How much do you enjoy car rides?",
//             type: .ranged,
//             answers: [
//                Answer(text: "I dislike them", type: .cat),
//                Answer(text: "I get a little nervous", type: .rabbit),
//                Answer(text: "I barely notice them", type: .turtle),
//                Answer(text: "I love them", type: .lion)
//             ]),
//    // NEW Question4
//    Question(text: "What's your ideal vacation?",
//             type: .single,
//             answers: [
//                Answer(text: "Beach resort", type: .turtle),
//                Answer(text: "Mountain cabin", type: .rabbit),
//                Answer(text: "Big city adventure", type: .lion),
//                Answer(text: "Cozy staycation", type: .cat)
//             ]),
//    // NEW Question 5
//    Question(text: "Which weather do you enjoy?",
//             type: .multiple,
//             answers: [
//                Answer(text: "Sunny and warm", type: .lion),
//                Answer(text: "Cool and breezy", type: .rabbit),
//                Answer(text: "Rainy and cozy", type: .cat),
//                Answer(text: "Mild and calm", type: .turtle)
//             ])
    
    // NEW QUESTIONS
    Question(
        text: "What quality do you value most?",
        type: .single,
        answers: [
            Answer(text: "Bravery", type: .gryffindor),
            Answer(text: "Loyalty", type: .hufflepuff),
            Answer(text: "Intelligence", type: .ravenclaw),
            Answer(text: "Ambition", type: .slytherin)
        ]
    ),
    
    Question(
        text: "Which classes would you take?",
        type: .multiple,
        answers: [
            Answer(text: "Defense Against Dark Arts", type: .gryffindor),
            Answer(text: "Herbology", type: .hufflepuff),
            Answer(text: "Charms", type: .ravenclaw),
            Answer(text: "Potions", type: .slytherin)
        ]
    ),
    
    Question(
        text: "How competitive are you?",
        type: .ranged,
        answers: [
            Answer(text: "Not at all", type: .hufflepuff),
            Answer(text: "Somewhat", type: .ravenclaw),
            Answer(text: "Very", type: .gryffindor),
            Answer(text: "Extremely", type: .slytherin)
        ]
    )
]



// MARK: - Testing Section (Remove this later)
// Think: "I need to wrap test code in a function because Swift doesn't allow
//         top-level expressions. This is like creating a main() method in Java."

//func testModels() {
//    print("\n=== TESTING MODELS ===\n")
//    
//    // Test 1: Can I create an instance?
//    let testAnswer = Answer(text: "Test", type: .lion)
//    print(" Test 1: Created answer: \(testAnswer.text)")
//    
//    // Test 2: Can I access the first question?
//    let firstQuestion = allQuestions[0]
//    print("Test 2: First question: \(firstQuestion.text)")
//    
//    // Test 3: Can I get an animal's raw value?
//    let lionEmoji = AnimalType.lion.rawValue
//    print("Test 3: Lion emoji: \(lionEmoji)")
//    
//    // Test 4: Can I get an animal's definition?
//    print("Test 4: Lion definition: \(AnimalType.lion.definition)")
//    
//    // Test 5: Can I loop through questions?
//    print("\nTest 5: Looping through all questions:")
//    for (index, question) in allQuestions.enumerated() {
//        print("  Question \(index + 1): \(question.text)")
//        print("    Type: \(question.type)")
//        print("    Answer count: \(question.answers.count)")
//    }
//    
//}



