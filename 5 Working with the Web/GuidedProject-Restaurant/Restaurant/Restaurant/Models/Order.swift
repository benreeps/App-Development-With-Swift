//
//  Order.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/24/21.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
