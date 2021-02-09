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
    
    private var itemsByID = [Int:MenuItem]()
    private var itemsByCategory = [String:[MenuItem]]()
    var categories: [String] {
        get {
            return itemsByCategory.keys.sorted()
        }
    }
    
    static let menuDataUpdatedNotification = Notification.Name("MenuController.menuDataUpdated")
    
    // Fetch updated objects from the server at the earliest opportunity when the app launches. Note that you're fetching against the base "menu" endpoint on the server to get all the items at once, rather than fetching one category at a time.
    private func process(_ items: [MenuItem]) {
        itemsByID.removeAll()
        itemsByCategory.removeAll()
        
        for item in items {
            itemsByID[item.id] = item
            itemsByCategory[item.category, default: []].append(item)
        }
        // Send a notification on completion of fetch
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: MenuController.menuDataUpdatedNotification, object: nil)
        }
    }
    
    func loadRemoteData() {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        let components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) {
            (data, _, _) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                self.process(menuItems.items)
            }
        }
        task.resume()
    }
    
    func loadItems() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentsDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: menuItemsFileURL) else {return}
        let items = (try? JSONDecoder().decode([MenuItem].self, from: data)) ?? []
        process(items)
    }
    
    func saveItems() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentsDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        let items = Array(itemsByID.values)
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: menuItemsFileURL)
        }
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
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
    //MARK:- Data persistence
    
    func loadOrder() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentsDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: orderFileURL) else {return}
        order = (try? JSONDecoder().decode(Order.self, from: data)) ?? Order(menuItems: [])
    }
    
    func saveOrder() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentsDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        if let data = try? JSONEncoder().encode(order) {
            try? data.write(to: orderFileURL)
        }
    }
    
    // Provide Synchronous Data Access
    func item(withID itemID: Int) -> MenuItem? {
        return itemsByID[itemID]
    }
    
    func item(forCategory category: String) -> [MenuItem]? {
        return itemsByCategory[category]
    }
    
}
