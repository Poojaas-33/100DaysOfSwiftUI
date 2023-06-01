//
//  ContentView.swift
//  WordScramble
//
//  Created by Pooja Agrawal on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @State private var score = 0
    
    func startGame() {
        
        usedWords.removeAll()
        score = 0
        //Find URL for start.text in our app bundle
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //load start.text into a string
            if let startWords = try? String(contentsOf: startWordURL) {
                //split the string into an array
                let allWords = startWords.components(separatedBy: "\n" )
                //Pick one random word or use a defualt word
                rootWord = allWords.randomElement() ?? "silkworm"
                //all good
                return
            }
        }
        fatalError("Could not load start.text from app bundle")
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingAlert = true
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isAllowed(word: answer) else {
            wordError(title: "Word is not allowed", message: "Think harder!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer,at: 0)
        }
        
        score = score + answer.count
        
        newWord = ""
    }
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Enter your word",text: $newWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                    .textInputAutocapitalization(.never)
                List {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                }
                
                Text("Score : \(score)").font(.largeTitle)
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle,isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("New Game",action: startGame)
            }
        }
    }
    
    func isAllowed(word: String) -> Bool {
        word.count >= 3 && word != rootWord
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word : String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
