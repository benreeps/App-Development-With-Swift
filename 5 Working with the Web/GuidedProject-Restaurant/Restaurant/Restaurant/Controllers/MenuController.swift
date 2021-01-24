//
//  MenuController.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/24/21.
//

import Foundation

class MenuController {
    let baseURL = URL(string: "http://localhost:8090/")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        
    }
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([String]?) -> Void) {
        
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        
    }
}
