//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 19.11.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            gameBody
            shuffleButton
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isSelected {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.scale)
                    .font(.largeTitle)
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
    }
    
    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20)).foregroundColor(.red).padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isSelected)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) * DrawingConstants.fontScale / DrawingConstants.fontSize
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circlePadding: CGFloat = 5
        static let circleOpacity: CGFloat = 0.5
        static let fontSize: CGFloat = 32
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemoryGame()
        
        viewModel.choose(viewModel.cards.first!)
        
        return EmojiMemoryGameView(game: viewModel)
    }
}
