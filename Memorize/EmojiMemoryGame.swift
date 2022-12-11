//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 26.11.2022.
//

import Foundation
import SwiftUI

class EmojiMemoryGame : ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { "\($0)" }
    
    private static func createNewGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in emojis[pairIndex] }
    }
    
    @Published private var model = createNewGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
