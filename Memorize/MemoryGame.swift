//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 26.11.2022.
//

import Foundation

struct MemoryGame<CardContent> {
    
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        let requiredCardIndex = cards.firstIndex(where: { $0.id == card.id })
        
        guard let requiredCardIndex = requiredCardIndex else {
            return
        }
        
        cards[requiredCardIndex].isFacedUp.toggle()
        print("\(cards)")
    }
                    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFacedUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
