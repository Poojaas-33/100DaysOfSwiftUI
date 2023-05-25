//
//  ContentView.swift
//  Challenge2
//
//  Created by Pooja Agrawal on 23/05/23.
//

import SwiftUI

struct MyText : View {
    var win : Bool
    var body : some View {
        if(win) {
            Text("Win").foregroundStyle(.secondary).font(.system(size:50).bold())
        }
        else {
            Text("Lose").foregroundStyle(.secondary).font(.system(size:50).bold())
        }
    }
}

struct ContentView: View {
    
    private var possibleMoves = ["🪨","📃","✂️"]
    
    @State private var gameRound = 1
    @State var score = 0
    @State private var choice = Int.random(in: 0...2)
    @State private var shouldWin = true
    @State private var showMessage = false
    @State private var alertPresented = false
    @State private var showingScore = false
    @State private var scoreMessage = ""
    
    func askQuestion() {
        choice = Int.random(in: 0...2)
        shouldWin.toggle()
        gameRound += 1
        if(gameRound > 10) {
            gameRound = 1
            alertPresented = true
        }
    }
    
    func restartGame() {
        gameRound = 1
        score = 0
        alertPresented = false
    }
    
    func tapButton(_ number : Int) {
        var correctAns : Int
        if(shouldWin) {
            switch(choice) {
            case 0 : correctAns = 1
            case 1: correctAns = 2
            case 2: correctAns = 0
            default : correctAns = -1
            }
        }
        else {
            switch(choice) {
            case 0 : correctAns = 2
            case 1: correctAns = 0
            case 2: correctAns = 1
            default : correctAns = -1
            }
        }
        
        if(number == correctAns) {
            score += 1;
            scoreMessage = "Correct"
        }
        else {
            scoreMessage = "Incorrect"
        }
        showingScore = true;
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient : Gradient(colors: [.red,.yellow,.red]),startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Text("Round \(gameRound)").font(.largeTitle.bold()).foregroundColor(.white)
                
                VStack(spacing : 15){
                    VStack {
                        MyText(win: shouldWin)
                        Text("\(possibleMoves[choice])").font(.system(size:100))
                    }
                }.frame(maxWidth : .infinity)
                    .padding(.vertical,20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                HStack (spacing:20){
                    ForEach(0..<3) { number in
                        Button {
                            tapButton(number)
                        } label : {
                            Text("\(possibleMoves[number])").font(.system(size:100))
                        }
                    }
                }
                Spacer()
                Text("Score : \(score)").font(.largeTitle.bold()).foregroundColor(.white)
                Spacer()
                
            }.padding()
        }.alert(scoreMessage, isPresented: $showingScore){
            Button("Continue",action: askQuestion)
        }.alert("Game Over", isPresented: $alertPresented) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
