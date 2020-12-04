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
    var showAlert = BehaviorSubject<Bool>(value: false)
    
    var eventDescription: String = ""
    var eventId: String = ""
    var eventTitle: String = ""
    
    // MARK: - Private Variable(s)
    
    private let bag = DisposeBag()
    
    // MARK: - Init
    
    init(eventId: String) {
        self.getEvent(with: eventId)
    }
    
    
    // MARK: - API Request
    
    func getEvent(with id: String)  {
        APIService.getEvent(with: id) { [weak self] (result) in
            switch result {
            case .success(let event):
                self?.date.onNext(event.date)
                self?.description.onNext(event.description)
                self?.imageURL.onNext(event.imageURL)
                self?.coordinates.onNext((latitude: event.latitude, longitude: event.longitude))
                self?.price.onNext(event.price)
                self?.eventDescription = event.description
                self?.eventId = event.id
                self?.eventTitle = event.title
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // MARK: - Data Transformation
    
    func convertToData(name: String, email: String) -> Result<Data,Error> {
        var dict: [String: String] = [:]
        dict.updateValue(eventId, forKey: "eventId")
        dict.updateValue(name, forKey: "name")
        dict.updateValue(email, forKey: "email")
        
        do {
            let encondedData = try JSONSerialization.data(withJSONObject: dict)
            return .success(encondedData)
        } catch {
            return .failure(error)
        }
    }
}
