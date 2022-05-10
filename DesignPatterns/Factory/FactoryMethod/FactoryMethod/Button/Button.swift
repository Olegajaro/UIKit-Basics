//
//  Button.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation
import UIKit

protocol Button {
    var title: String { get }
    var color: UIColor { get }
    var titleColor: UIColor { get }
    
    func configureButton()
}
