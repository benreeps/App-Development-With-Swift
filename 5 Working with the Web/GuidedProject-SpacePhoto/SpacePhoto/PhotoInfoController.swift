//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Benjamin Reeps on 1/13/21.
//

import Foundation
import UIKit

struct PhotoInfoController {
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        
        // Create a [String: String] dictionary with keys and values that match your queries. Then update your url value to use the new withQueries(_:) method to generate the full URL
        
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String: String] = ["api_key": "DEMO_KEY", "date": "2018-01-18"]
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, URLResponse, Error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
                
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                completion(nil)
            }
        }
         
        task.resume()
    }
    
}
