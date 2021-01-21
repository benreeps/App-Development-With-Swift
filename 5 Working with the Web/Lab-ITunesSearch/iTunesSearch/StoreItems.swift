//
//  StoreItems.swift
//  iTunesSearch
//
//  Created by Benjamin Reeps on 1/21/21.
//  Copyright © 2021 Caleb Hicks. All rights reserved.
//

import Foundation

struct StoreItems: Codable {
    let results: [StoreItem]
}

struct StoreItem: Codable {
    var artist: String
    var mediaType: String
    var songName: String
    var description: String?
    var longDescription: String?
    
    enum Keys: String, CodingKey {
        case artist = "artistName"
        case mediaType = "kind"
        case songName = "trackName"
        case description = "wrapperType"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: Keys.self)
        self.artist = try valueContainer.decode(String.self, forKey: Keys.artist)
        self.mediaType = try valueContainer.decode(String.self, forKey: Keys.mediaType)
        self.songName = try valueContainer.decode(String.self, forKey: Keys.songName)
        // This statement ensures that a description or a long description will be accepted if available
        if let description = try? valueContainer.decode(String.self, forKey: Keys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}
