//
//  Jumping.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation

class Jumping: Exercise {
    
    var name: String = "Jumping"
    var type: String = "Legs"
    
    func start() {
        print("Start jumping")
    }
    
    func stop() {
        print("Stop jumping")
    }
}
