//
//  MenuController.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/24/21.
//

import Foundation
import UIKit

class MenuController {
    static let shared = MenuController()
    // This is a new notification that will be sent when the user updates their order
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    var order = Order() {
        // This is an observer  will send your updated order notification every time the order is modified
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
               let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let categories = jsonDictionary["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
                print("error fetching categories")
            }
        }
        task.resume()
    }
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
                print("error fetching menu items")
            }
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
                print("error submitting order")
            }
        }
        task.resume()
    }
}
