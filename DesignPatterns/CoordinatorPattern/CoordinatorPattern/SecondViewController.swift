//
//  SecondViewController.swift
//  CoordinatorPattern
//
//  Created by Олег Федоров on 20.04.2022.
//

import UIKit

class SecondViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Second"
        view.backgroundColor = .systemGreen
    }

}
