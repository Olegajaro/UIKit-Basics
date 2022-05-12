//
//  AbstractFactory.swift
//  ExAbstractFactory
//
//  Created by Олег Федоров on 12.05.2022.
//

import Foundation

protocol AbstractFactory {
    func createGuitar() -> Guitar
    func createBass() -> BassGuitar
}
