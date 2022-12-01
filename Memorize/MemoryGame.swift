//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 26.11.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    
    private(set) var cards: Array<Card>
    
    private var selectedCardIndex: Int? {
        get { cards.indices.filter { cards[$0].isSelected }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isSelected = ($0 == newValue) } }
    }

    mutating func choose(_ card: Card) {
        guard
            let requiredCardIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[requiredCardIndex].isMatched,
            !cards[requiredCardIndex].isSelected
        else {
            return
        }
        
        if let selectedCardIndex = self.selectedCardIndex {
            
            if cards[selectedCardIndex].content == cards[requiredCardIndex].content {
                cards[requiredCardIndex].isMatched = true
                cards[selectedCardIndex].isMatched = true
            }
            
            cards[requiredCardIndex].isSelected = true
        } else {
            selectedCardIndex = requiredCardIndex
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var isSelected = false
        var isMatched = false
        var content: CardContent
    }
}

extension Array {
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}
