//
//  URL+Helpers.swift
//  iTunesSearch
//
//  Created by Benjamin Reeps on 1/21/21.
//  Copyright © 2021 Caleb Hicks. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1)
        }
        return components?.url
    }
}
