//
//  Order.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/24/21.
//

import Foundation

struct Order: Codable {
    var menuItems = [MenuItem]
    
    init(menuitems: [MenuItem] = []) {
        self.menuItems = menuitems
    }
}
