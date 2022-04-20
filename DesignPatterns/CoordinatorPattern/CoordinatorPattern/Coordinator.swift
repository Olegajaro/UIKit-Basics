//
//  Coordinator.swift
//  CoordinatorPattern
//
//  Created by Олег Федоров on 20.04.2022.
//

import Foundation
import UIKit

enum Event {
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(withType: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
