//
//  ContentView.swift
//  Animations
//
//  Created by Pooja Agrawal on 02/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var scaleValue = 1.0
    
    var body: some View {
        Button("Tap ME"){
            //scaleValue += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        //.scaleEffect(scaleValue)
        //.blur(radius: (scaleValue-1)*2)
        .overlay (
            Circle()
                .stroke(.red)
                .scaleEffect(scaleValue)
                .opacity(2-scaleValue)
                .animation(.easeInOut(duration: 1)
                    .repeatForever(autoreverses:false), value: scaleValue)
        )
        .onAppear{
            scaleValue = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
