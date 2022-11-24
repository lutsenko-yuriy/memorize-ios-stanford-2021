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
            CardView(content: "😀")
            CardView(content: "🧐")
            CardView(content: "😝")
            CardView(content: "😎")
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content = "🤪"
    @State var isFaceUp: Bool = false
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20.0)
        ZStack {
            if isFaceUp {
                shape.fill(.white)
                shape.stroke(lineWidth: 3.0)
                    .foregroundColor(.red)
                Text(content).font(.largeTitle)
            } else {
                shape.fill(.red)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
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
