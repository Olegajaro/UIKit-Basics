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
        
        indexTheme = keys.count.acr4random
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
//        game.flipCount += 1
        if let buttonIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel() 
        } else {
            print("Choosen card was not in cardButtons")
        }
    }
    
    @IBAction func startNewGame() {
        game.resetGame()
        indexTheme = keys.count.acr4random
        updateViewFromModel()
        flipCount = 0
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
                ? .clear
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
            string: "Flips \(flipCount)",
            attributes: attr
        )
        flipCountLabel.attributedText = attrText
    }
    
//    private var emoji = ["👻", "🎃", "😈", "🐉", "🐢", "😱", "🐰", "🍭", "🍎"]
    private var emoji = "👻🎃😈🐉🐢😱🐰🍭🍎♠️♣️♥️📝🐶🗑"
    
    private var indexTheme = 0 {
        didSet {
            print(indexTheme, keys[indexTheme])
            emoji = emojiThemes[keys[indexTheme]] ?? ""
            dictEmoji = [Card: String]()
        }
    }
    
    private var keys: [String] {
        return Array(emojiThemes.keys)
    }
    
    private var emojiThemes: [String: String] = [
        "Halloween": "👻😈😱🎃👽🧙⚰️🕸🦇🕷🧟‍♂️💀",
        "Sport": "⚽️🏈🏒🏑🏀⛷🏋️‍♀️🏃‍♂️⛸🏊‍♀️🎾🏸",
        "Animals": "🐈🐩🐁🐇🐢🐴🦊🐸🦋🐻🐺🦓",
        "Faces": "😇😘🤓🤯🤑🤧😬🤗🤩🤪😎🤬",
        "Fruits": "🍌🍏🍍🍉🥭🍊🍓🍒🍇🫐🥝🍈",
        "Cars": "🚘🚒🚛🚜🚑🚙🚚🚌🚐🏍🚎🚓"
    ]
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
