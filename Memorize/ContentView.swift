//
//  ContentView.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 19.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView(isFaceUp: false)
            CardView(isFaceUp: false)
            CardView()
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var isFaceUp: Bool = true
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20.0)
        if isFaceUp {
            ZStack {
                shape.fill(.white)
                shape.stroke(lineWidth: 3.0)
                    .foregroundColor(.red)
                Text("🤪").font(.largeTitle)
            }
        } else {
            shape.fill(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
