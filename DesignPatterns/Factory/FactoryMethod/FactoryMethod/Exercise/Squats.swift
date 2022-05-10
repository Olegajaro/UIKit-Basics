//
//  Squats.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation

class Squats: Exercise {
    var name: String = "Squats"
    var type: String = "Legs"
    
    func start() {
        print("Start squats")
    }
    
    func stop() {
        print("Stop squats")
    }
}
