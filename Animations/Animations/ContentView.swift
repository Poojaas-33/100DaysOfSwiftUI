//
//  ContentView.swift
//  Animations
//
//  Created by Pooja Agrawal on 02/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = true
    
    var body: some View {
    
            Button("Tap Me") {
                enabled.toggle()
            }
            .padding(50)
            .background(enabled ? .green : .red)
            .animation(nil, value: enabled)
            .foregroundColor(.white)
            //.clipShape(Circle())
            .clipShape(RoundedRectangle(cornerRadius:  enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 20, damping: 1), value: enabled)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
