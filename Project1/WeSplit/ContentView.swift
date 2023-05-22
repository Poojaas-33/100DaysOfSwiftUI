//
//  ContentView.swift
//  WeSplit
//
//  Created by Pooja Agrawal on 21/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercent = 20
    @FocusState private var amountIsFocused : Bool
    
    let currecyFormat : FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    let tipPercentages = [5,10,15,20,25,0]
    
    var totalPerPerson : Double {
        //calculate total amount to be paid by each person
        let peopleCount = Double(numOfPeople + 2)
        let tipSelection = Double(tipPercent)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal / peopleCount
    }
    
    var grandTotal : Double {
        let tipSelection = Double(tipPercent)
        let tipValue = checkAmount/100 * tipSelection
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value : $checkAmount, format : currecyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percent", selection: $tipPercent) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header : {
                    Text("How much tip you want to leave?")
                }
                
                Section{
                    Text(grandTotal,format: currecyFormat)
                } header: {
                    Text("Total check amount")
                }
                
                Section{
                    Text(totalPerPerson, format : currecyFormat)
                } header : {
                    Text("Amount per person")
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
