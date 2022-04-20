//
//  ViewController.swift
//  CoordinatorPattern
//
//  Created by Олег Федоров on 20.04.2022.
//

import UIKit

class HomeViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        button.backgroundColor = .systemGreen
        button.setTitle("Go to the Second Screen", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .systemRed
        
        view.addSubview(button)
        button.center = view.center
        button.addTarget(self,
                         action: #selector(didTapButton),
                         for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        coordinator?.eventOccured(withType: .buttonTapped)
    }
}

