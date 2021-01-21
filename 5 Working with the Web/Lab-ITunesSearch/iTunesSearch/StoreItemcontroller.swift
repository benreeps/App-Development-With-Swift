//
//  StoreItemcontroller.swift
//  iTunesSearch
//
//  Created by Benjamin Reeps on 1/21/21.
//  Copyright © 2021 Caleb Hicks. All rights reserved.
//

import Foundation

func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {

    let baseURL = URL(string: "http://itunes.apple.com/search")!
    guard let url = baseURL.withQueries(query) else {
        completion(nil)
        print("Unable to find url with queries provided.")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        let jsonDecoder = JSONDecoder()
        if let data = data,
        let storeItems = try? jsonDecoder.decode(StoreItems.self, from: data) {
            completion(storeItems.results)
           
        } else {
            print("Either no data was returned or data was not properly decoded")
            completion(nil)
            return
        }
    }
    task.resume()
}
