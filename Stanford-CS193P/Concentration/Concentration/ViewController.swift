//
//  ViewController.swift
//  Concentration
//
//  Created by Олег Федоров on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            let attr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 40)
            ]
            let attrString = NSAttributedString(
                string: emoji(for: card),
                attributes: attr
            )
            
            if card.isFaceUp {
                button.setAttributedTitle(attrString, for: .normal)
                button.backgroundColor = .white
            } else {
                button.setAttributedTitle(
                    NSAttributedString(string: ""),
                    for: .normal
                )
                button.backgroundColor = card.isMatched
                ? .systemOrange.withAlphaComponent(0)
                : .systemOrange
            }
        }
    }
    
    private func updateFlipCountLabel() {
        let attr: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.systemYellow
        ]
        let attrText = NSAttributedString(
            string: "Flip Count: \(flipCount)",
            attributes: attr
        )
        flipCountLabel.attributedText = attrText
    }
    
//    private var emoji = ["👻", "🎃", "😈", "🐉", "🐢", "😱", "🐰", "🍭", "🍎"]
    private var emoji = "👻🎃😈🐉🐢😱🐰🍭🍎"
    private var dictEmoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        if dictEmoji[card] == nil, emoji.count > 0 {
            let randomStringIndex = emoji.index(
                emoji.startIndex,
                offsetBy: emoji.count.acr4random
            )
            dictEmoji[card] = String(emoji.remove(at: randomStringIndex)) 
        }
        
        return dictEmoji[card] ?? "?"
    }
}

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
