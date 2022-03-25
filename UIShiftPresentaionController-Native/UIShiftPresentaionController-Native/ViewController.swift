//
//  ViewController.swift
//  UIShiftPresentaionController-Native
//
//  Created by Олег Федоров on 25.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension ViewController {
    private func style() {
        title = "Main"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.setTitle("Modal", for: .normal)
        button.addTarget(self,
                         action: #selector(presentModal),
                         for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Basic Usage
//extension ViewController {
//    @objc func presentModal(sender: UIButton) {
//        let detailVC = DetailViewController()
//
//        if let sheet = detailVC.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//        }
//
//        present(detailVC, animated: true, completion: nil)
//    }
//}

// MARK: - How to prevent scrolling up
//extension ViewController {
//    @objc func presentModal(sender: UIButton) {
//        let detailVC = DetailViewController()
//        let navController = UINavigationController(rootViewController: detailVC)
//
//
//        if let sheet = navController.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//            sheet.selectedDetentIdentifier = .large
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//        }
//
//        present(navController, animated: true, completion: nil)
//    }
//}

// MARK: - Intercat with underneath content
//extension ViewController {
//    @objc func presentModal(sender: UIButton) {
//        let detailVC = DetailViewController()
//        let navController = UINavigationController(rootViewController: detailVC)
//
//        if let sheet = navController.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//            sheet.largestUndimmedDetentIdentifier = .medium
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//        }
//
//        present(navController, animated: true, completion: nil)
//    }
//}

// MARK: - Prevent Dismissal
//extension ViewController {
//    @objc func presentModal(sender: UIButton) {
//        let detailVC = DetailViewController()
//        let navController = UINavigationController(rootViewController: detailVC)
//        navController.isModalInPresentation = true
//
//        if let sheet = navController.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//            sheet.largestUndimmedDetentIdentifier = .medium
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//        }
//
//        present(navController, animated: true, completion: nil)
//    }
//}

// MARK: - Programmatically change the size
extension ViewController {
    @objc func presentModal(sender: UIButton) {
        let detailVC = DetailViewController()
        let navController = UINavigationController(rootViewController: detailVC)
        
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 30
            sheet.prefersGrabberVisible = true
        }
        
        let medium = UIBarButtonItem(
            title: "Medium",
            primaryAction: .init(handler: { _ in
                if let sheet = navController.sheetPresentationController {
                    sheet.animateChanges {
                        sheet.selectedDetentIdentifier = .medium
                    }
                }
            })
        )
        
        let large = UIBarButtonItem(
            title: "Large",
            primaryAction: .init(handler: { _ in
                if let sheet = navController.sheetPresentationController {
                    sheet.animateChanges {
                        sheet.selectedDetentIdentifier = .large
                    }
                }
            })
        )
        
        detailVC.navigationItem.leftBarButtonItem = medium
        detailVC.navigationItem.rightBarButtonItem = large
        
        present(navController, animated: true, completion: nil)
    }
}
