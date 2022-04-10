//
//  ViewController.swift
//  PlayingCard
//
//  Created by Олег Федоров on 10.04.2022.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(
                target: self,
                action: #selector(nextCard)
            )
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(
                target: playingCardView,
                action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:))
            )
            playingCardView.addGestureRecognizer(pinch)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
        
    }
    
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
}

