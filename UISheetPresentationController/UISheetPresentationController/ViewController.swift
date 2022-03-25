//
//  ViewController.swift
//  UISheetPresentationController
//
//  Created by Олег Федоров on 25.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func presentModal(_ sender: Any) {
        let topAnchorValue = UIScreen.main.bounds.height * 0.5
        let vc = SelectorViewController(topAnchorValue: topAnchorValue)
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

