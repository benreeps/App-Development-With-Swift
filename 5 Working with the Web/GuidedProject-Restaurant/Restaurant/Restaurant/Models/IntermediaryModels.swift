//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/24/21.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
