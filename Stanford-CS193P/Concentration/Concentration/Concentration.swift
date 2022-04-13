//
//  Concentration.swift
//  Concentration
//
//  Created by Олег Федоров on 08.04.2022.
//

import Foundation

struct Concentration {
    
    private struct Points {
        static let mathBonus = 2
        static let missMatchPenalty = 1
    }
    
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            /*
             var foundIndex: Int?
             for index in cards.indices {
                 if cards[index].isFaceUp {
                     if foundIndex == nil {
                         foundIndex = index
                     } else {
                         return nil
                     }
                 }
             }
             return foundIndex
             */
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(
            cards.indices.contains(index),
            "Concentration.chooseCard(at: \(index)): chosen index not in the cards"
        )
        if !cards[index].isMatched {
            flipCount += 1
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // Increase the score
                    score += Points.mathBonus
                } else {
                    // cards didn't match - Penalize
                    if seenCards.contains(index) {
                        score -= Points.missMatchPenalty
                    }
                    
                    if seenCards.contains(matchIndex) {
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
        score = 0
        seenCards = []
        flipCount = 0
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(
            numberOfPairsOfCards > 0,
            "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards"
        )
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        cards.shuffle()
    }
}
