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
    
    
    mutating func shuffle() {
        cards.shuffle()
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
        var isSelected = false {
            didSet {
                if isSelected {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        
        
        // MARK: - Bonus Time
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isSelected && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}
