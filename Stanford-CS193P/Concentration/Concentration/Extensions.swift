//
//  Extensions.swift
//  Concentration
//
//  Created by Олег Федоров on 13.04.2022.
//

import Foundation

extension Int {
    var acr4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.acr4random)
            swapAt(i, j)
        }
    }
}

extension Date {
    var sinceNow: Int {
        return -Int(self.timeIntervalSinceNow)
    }
}
