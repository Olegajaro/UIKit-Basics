//
//  MainCoordinator.swift
//  CoordinatorPattern
//
//  Created by Олег Федоров on 20.04.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccured(withType type: Event) {
        switch type {
        case .buttonTapped:
            var vc: UIViewController & Coordinating = SecondViewController()
            vc.coordinator = self
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = HomeViewController()
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}
