//
//  AcousticFactory.swift
//  ExAbstractFactory
//
//  Created by Олег Федоров on 12.05.2022.
//

import Foundation

class AcousticFactory: AbstractFactory {
    func createGuitar() -> Guitar {
        print("DEBUG: build acoustic guitar")
        return AcousticGuitar()
    }
    
    func createBass() -> BassGuitar {
        print("DEBUG: build acoustic bass")
        return AcousticBassGuitar()
    }
}
