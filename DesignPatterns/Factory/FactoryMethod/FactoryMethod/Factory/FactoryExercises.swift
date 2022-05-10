//
//  FactoryExercises.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation

enum Exercises {
    case jumping
    case squats
    case benchPress
}

class FactoryExercises {
    
    static let shared = FactoryExercises()
    private init() {}
    
    func createExercise(type: Exercises) -> Exercise {
        switch type {
        case .jumping: return Jumping()
        case .squats: return Squats()
        case .benchPress: return BenchPress()
        }
    }
}
