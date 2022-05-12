//
//  ElectroFactory.swift
//  ExAbstractFactory
//
//  Created by Олег Федоров on 12.05.2022.
//

import Foundation

class ElectroFactory: AbstractFactory {
    func createGuitar() -> Guitar {
        print("DEBUG: build electro guitar")
        return ElectroGuitar()
    }
    
    func createBass() -> BassGuitar {
        print("DEBUG: build electro bass")
        return ElectroBass()
    }
}
