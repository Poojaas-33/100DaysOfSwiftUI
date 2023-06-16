//
//  ContentView.swift
//  Project5
//
//  Created by Pooja Agrawal on 14/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.personalItem) { item in
                        HStack {
                            if(item.type == "Personal") {
                                Text(item.name).font(.headline)
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundColor(item.amount <= 10 ? .green : item.amount<=100 ? .yellow : .red)
                            }
                        }
                    }.onDelete(perform: removeItems)
                } header: {
                    Text("Personal")
                }
                
                Section {
                    ForEach(expenses.businessItem) { item in
                        HStack {
                            if(item.type == "Business") {
                                Text(item.name).font(.headline)
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundColor(item.amount <= 10 ? .green : item.amount<=100 ? .yellow : .red )
                            }
                        }
                    }.onDelete(perform: removeItems)
                } header: {
                    Text("Business")
                }
            }.toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }.navigationTitle("iExpense")
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets : IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
