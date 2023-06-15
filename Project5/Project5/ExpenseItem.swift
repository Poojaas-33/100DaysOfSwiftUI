//
//  ExpenseItem.swift
//  Project5
//
//  Created by Pooja Agrawal on 14/06/23.
//

import Foundation

struct ExpenseItem : Identifiable,Codable {
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
}

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded,forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
