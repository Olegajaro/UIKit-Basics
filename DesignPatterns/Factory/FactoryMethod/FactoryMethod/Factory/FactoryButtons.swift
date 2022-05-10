//
//  FactoryButtons.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation
import UIKit

enum ButtonType {
    case standart
    case cancel
    case rounded
}

class FactoryButtons {
    
    static let shared = FactoryButtons()
    private init() {}
    
    func createButton(type: ButtonType) -> Button {
        switch type {
        case .standart:
            return StandartButton(type: .system)
        case .cancel:
            return CancelButton(type: .close)
        case .rounded:
            return RoundedButton(type: .roundedRect)
        }
    }
}
