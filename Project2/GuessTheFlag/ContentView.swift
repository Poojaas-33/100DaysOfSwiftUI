//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pooja Agrawal on 28/03/23.
//

import SwiftUI

struct FlagImage : View {
    var number : String
    var body : some View {
        Image(number)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var incorrectMessage = false
    @State private var gameOver = false
    @State private var questionCount = 0
    @State private var buttonTapped = -1
    @State private var animationAmount = 0.0
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    func restart() {
        questionCount = 0
        gameOver = false
        score = 0
        askQuestion()
    }
    
    func flagTapped(_ number: Int ){
        buttonTapped = number
        if number == correctAns {
            scoreTitle = "Correct"
            score += 1
            incorrectMessage = false
        }
        else {
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
            incorrectMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                showingScore = true}
    }
    
    func askQuestion() {
        buttonTapped = -1
        countries.shuffle();
        correctAns = Int.random(in: 0...2)
        questionCount += 1
        if questionCount == 8 {
            gameOver = true
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76,green: 0.15,blue: 0.26), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing : 15){
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAns]).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation {
                                animationAmount += 360
                            }
                        } label : {
                            FlagImage(number: countries[number])
                                .rotation3DEffect(.degrees(buttonTapped == number ? animationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
                                .opacity(buttonTapped == number || buttonTapped == -1 ? 1 : 0.3)
                                .scaleEffect(buttonTapped == number || buttonTapped == -1 ? 1 : 0.5)
                                .animation(.default, value: buttonTapped)
                                
                        }
                    }
                }.frame(maxWidth : .infinity)
                    .padding(.vertical,20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score) ")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue",action: askQuestion)
        } message: {
            Text ("Your score is \(score)")
        }.alert("Game Over", isPresented: $gameOver) {
            Button("Restart",action: restart)
        } message: {
            Text("Game is over! Your final score is \(score)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
