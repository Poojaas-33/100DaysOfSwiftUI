//
//  ContentView.swift
//  BetterRest
//
//  Created by Pooja Agrawal on 26/05/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShow = false
    
    //if we want to eliminate the calculate button
    /*var recommendedSleepTime : String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "ERROR"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        return "NOW"
    }*/

    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "ERROR"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        alertShow = true
    }
    
    var body: some View {
        NavigationView {
            Form {
                //if we want to use section instead of VStack
                /*
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp,displayedComponents:.hourAndMinute).labelsHidden()
                } header : {
                    Text("When do you want to wake up?")
                }*/
                
                VStack ( alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing : 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours",value: $sleepAmount, in : 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0){
                    //if we want to use picker instead of stepper
                    /*Picker("Daily coffee intake",selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0) cups")
                        }
                    }*/
                    
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in : 1...20)
                }
                //Text("Recommended Bedtime : \(recommendedSleepTime)")
            }.navigationTitle("BetterRest")
            .toolbar{
                    Button("Calculate", action: calculateBedtime)
            }.alert(alertTitle, isPresented: $alertShow) {
                Button("OK"){}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
