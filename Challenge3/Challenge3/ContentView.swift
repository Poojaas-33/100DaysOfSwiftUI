//
//  ContentView.swift
//  Challenge3
//
//  Created by Pooja Agrawal on 08/06/23.
//

import SwiftUI

struct Questions {
    var question : String
    var answer : Int
}

struct ContentView: View {
    
    @State private var level = 2
    @State private var gameStarted = false
    @State private var questionNumber = 0
    @State private var ans : Int? = nil
    @State private var round = 5
    @State private var score = 0
    @State private var endGame = false
    @State private var ques: [Questions] = []
    
        var body: some View {
            if !gameStarted {
                NavigationView {
                    Form {
                        Section("Which multiplication table you want to practice?") {
                            Stepper("\(level)",value : $level, in : 2...12)
                        }
                        Section("How many questions?") {
                            
                            Stepper("\(round)",value: $round, in: 5...15, step: 5)
                        }
                    }
                    .navigationTitle("Edutainment")
                    .toolbar {
                        Button("Start") {
                            gameStarted = true
                            startGame()
                        }
                    }
                }
                .alert("Game Over", isPresented: $endGame) {
                    Button("OK") { }
                } message: {
                    Text("Your final score is: \(score)/\(round)")
                }
            } else {
                NavigationView {
                    VStack {
                        Spacer()
                        Text("Round \(questionNumber+1)")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("\(ques[questionNumber].question)")
                            .font(.largeTitle)
                        Spacer()
                        TextField("answer", value: $ans, format: .number)
                            .keyboardType(.numberPad)
                            
                        Spacer()
                        Button(questionNumber+1 == round ? "End" : "Next") {
                            nextQuestion()
                        }
                        .frame(width: 100, height: 40)
                        .background(questionNumber+1 == round ? .red : .green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    .navigationTitle("Edutainment")
                }
            }
        }
        
        func startGame() {
            score = 0
            questionNumber = 0
            generateQuestions()
        }
        
        func nextQuestion() {
            print(ques[questionNumber].answer)
            if ques[questionNumber].answer==ans {
                score += 1
            }
            questionNumber += 1
            if questionNumber == round{
                gameStarted = false
                endGame = true
            }
        }
    
    func generateQuestions() {
        for _ in 0..<round {
            let num = Int.random(in: 2...12)
            ques.append(Questions(question: "\(level) x \(num)", answer: level*num))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
