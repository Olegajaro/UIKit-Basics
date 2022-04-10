//
//  Card.swift
//  Concentration
//
//  Created by Олег Федоров on 08.04.2022.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
