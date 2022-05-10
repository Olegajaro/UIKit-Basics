//
//  BenchPress.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation

class BenchPress: Exercise {
    var name: String = "Bench press"
    var type: String = "Chest"
    
    func start() {
        print("Start bench press")
    }
    
    func stop() {
        print("Stop bench press")
    }
}
