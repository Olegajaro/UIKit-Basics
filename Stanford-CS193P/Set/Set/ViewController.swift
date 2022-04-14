//
//  ViewController.swift
//  Set
//
//  Created by Олег Федоров on 14.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardButtons: [BorderButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtonsFromModel()
    }

    private func updateButtonsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle(String(index), for: .normal)
            if index > 11 {
                button.isHidden = true
            }
        }
    }
}

