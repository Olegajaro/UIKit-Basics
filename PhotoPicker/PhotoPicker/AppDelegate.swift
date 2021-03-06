//
//  AppDelegate.swift
//  PhotoPicker
//
//  Created by Олег Федоров on 19.04.2022.
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
        
        let navVC = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navVC
        
        return true
    }
}

