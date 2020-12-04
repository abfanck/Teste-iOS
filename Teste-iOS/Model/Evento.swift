//
//  Event.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import Foundation

struct Evento: Codable {
    
    let date: Date
    let description: String
    let id: String
    let imageURL: URL
    let latitude: Float
    let longitude: Float
    let price: Float
    let timeInterval: TimeInterval
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case description, id, latitude, longitude, price, title
        case imageURL = "image"
        case timeInterval = "date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        description = try values.decode(String.self, forKey: .description)
        id = try values.decode(String.self, forKey: .id)
        imageURL = try values.decode(URL.self, forKey: .imageURL)
        latitude = try values.decode(Float.self, forKey: .latitude)
        longitude = try values.decode(Float.self, forKey: .longitude)
        price = try values.decode(Float.self, forKey: .price)
        timeInterval = try values.decode(TimeInterval.self, forKey: .timeInterval)
        title = try values.decode(String.self, forKey: .title)
        
        date = Date(timeIntervalSince1970: timeInterval)
    }
}
