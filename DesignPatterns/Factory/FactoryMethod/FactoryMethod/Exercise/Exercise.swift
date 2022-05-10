//
//  Exercise.swift
//  FactoryMethod
//
//  Created by Олег Федоров on 10.05.2022.
//

import Foundation

protocol Exercise {
    
    var name: String { get }
    var type: String { get }
    
    func start()
    func stop()
}
