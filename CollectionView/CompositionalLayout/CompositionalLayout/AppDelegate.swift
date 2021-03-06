//
//  AppDelegate.swift
//  CompositionalLayout
//
//  Created by Олег Федоров on 30.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
//        let navController = UINavigationController(
//            rootViewController: ListViewController()
//        )
        
//        let navController = UINavigationController(
//            rootViewController: GridViewController()
//        )
        
//        let navController = UINavigationController(
//            rootViewController: TwoColumnGridViewController()
//        )
        
        let navController = UINavigationController(
            rootViewController: GridWithBadgesViewController()
        )
        
        window?.rootViewController = navController
        
        return true
    }
}

