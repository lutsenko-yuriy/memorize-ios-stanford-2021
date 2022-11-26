//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 26.11.2022.
//

import Foundation
import SwiftUI

class EmojiMemoryGame {
    
    static let emojis = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { "\($0)" }
    
    static func createNewGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in emojis[pairIndex] }
    }
    
    private var model: MemoryGame<String> = createNewGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
}
