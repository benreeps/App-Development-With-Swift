//
//  MenuItem.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/24/21.
//

import Foundation

struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Int
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
        
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}
