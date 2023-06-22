//
//  ContentView.swift
//  Moonshot
//
//  Created by Pooja Agrawal on 16/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingGrid = false
    
    var body: some View {
        NavigationView {
            Group {
                if isShowingGrid {
                    GridLayout()
                } else {
                    ListLayout()
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Change Layout") {
                    isShowingGrid.toggle()
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
