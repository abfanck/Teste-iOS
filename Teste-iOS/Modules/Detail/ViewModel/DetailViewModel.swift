//
//  DetailViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    // MARK: - Public Variable(s)
    
    var date = PublishSubject<Date>()
    var description = PublishSubject<String>()
    var imageURL = PublishSubject<URL>()
    var coordinates = PublishSubject<(latitude: Float, longitude: Float)>()
    var price = PublishSubject<Float>()
    
    // MARK: - Private Variable(s)
    
    private let bag = DisposeBag()
    
    // MARK: - Init
    
    init(eventId: String) {
        self.getEvent(with: eventId)
    }
    
    func getEvent(with id: String)  {
        APIService.getEvent(with: id) { (result) in
            switch result {
            case .success(let event):
                self.date.onNext(event.date)
                self.description.onNext(event.description)
                self.imageURL.onNext(event.imageURL)
                self.coordinates.onNext((latitude: event.latitude, longitude: event.longitude))
                self.price.onNext(event.price)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
