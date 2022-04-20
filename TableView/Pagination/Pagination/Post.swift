//
//  Post.swift
//  Pagination
//
//  Created by Олег Федоров on 26.03.2022.
//

import Foundation

struct Post: Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
