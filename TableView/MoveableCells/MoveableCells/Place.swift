//
//  Place.swift
//  MoveableCells
//
//  Created by Олег Федоров on 19.05.2022.
//

import Foundation

let cities = ["Moscow", "Minsk", "London", "Seoul", "Paris", "Madrid"]

struct Place: Hashable {
    let name: String
    
    static func getPlaces() -> [Place] {
        
        var places: [Place] = []
        
        for city in cities {
            places.append(Place(name: city))
        }
        
        return places
    }
}
