//
//  ContentView.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 19.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 100))]) {
                    ForEach(viewModel.cards) {
                        CardView(content: $0.content, isFaceUp: $0.isFacedUp)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            Spacer()
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String = ""
    var isFaceUp: Bool = false
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20.0)
        ZStack {
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3.0)
                    .foregroundColor(.red)
                Text(content).font(.largeTitle)
            } else {
                shape.fill(.red)
            }
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
