//
//  ContentView.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 19.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .font(.largeTitle)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
        
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20.0)
        ZStack {
            if card.isFacedUp || card.isMatched {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3.0)
                    .foregroundColor(.red)
                Text(card.content)
                    .font(.largeTitle)
                    .fontWeight(.black)
            } else {
                shape.fill(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemoryGame()
        
        ContentView(viewModel: viewModel)
            .preferredColorScheme(.dark)
        ContentView(viewModel: viewModel)
            .preferredColorScheme(.light)
    }
}
