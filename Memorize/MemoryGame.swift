//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 26.11.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    
    private(set) var cards: Array<Card>
    
    private(set) var selectedCardIndex: Int?
    
    mutating func choose(_ card: Card) {
        guard let requiredCardIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            return
        }
        
        guard
            !cards[requiredCardIndex].isMatched,
            !cards[requiredCardIndex].isFacedUp
        else {
            return
        }
        
        if selectedCardIndex == nil {
            resetCardsFacingUp()
        }
        
        cards[requiredCardIndex].isFacedUp.toggle()
        
        if selectedCardIndex == nil {
            selectedCardIndex = requiredCardIndex
            return
        }
        
        
        if cards[selectedCardIndex!].content == cards[requiredCardIndex].content {
            cards[requiredCardIndex].isMatched = true
            cards[selectedCardIndex!].isMatched = true
        }
        
        selectedCardIndex = nil
    }
    
    private mutating func resetCardsFacingUp() {
        for i in cards.indices {
            cards[i].isFacedUp = false
        }
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
        var isFacedUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
