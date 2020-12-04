//
//  DetailViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import Foundation

class DetailViewModel {
    
    // MARK: - Public Variable(s)
    
    var date: Date {
        event.date
    }
    
    var description: String {
        event.description
    }
    
    var imageURL: URL {
        event.imageURL
    }
    
    var latitude: Float {
        event.latitude
    }
    
    var longitude: Float {
        event.longitude
    }
    
    var price: Float {
        event.price
    }
    
    // MARK: - Private Variable(s)
    
    private var event: Event
    
    // MARK: - Init
    
    init(event: Event) {
        self.event = event
    }
}
