//
//  CancelButton.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation
import UIKit

class CancelButton: UIButton, Button {
    var title: String = "Cancel"
    var color: UIColor = .systemRed
    var titleColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
        setTitle(title, for: .normal)
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
    }
}
