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
    
    var date: Date {
        event.date
    }
    
    var description: String {
        event.description
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
    
    var imageSubject = BehaviorSubject<Data?>(value: nil)
    
    
    // MARK: - Private Variable(s)
    
    private var event: Event
    private let apiService = APIService.shared
    private let bag = DisposeBag()
    
    // MARK: - Init
    
    init(event: Event) {
        self.event = event
        self.getImageData()
    }
    
    
    // MARK: - API Request
    
    func getImageData() {
        apiService.getDataFrom(url: event.imageURL)
            .filter({ $0 != nil })
            .subscribe(
                onNext: { (data) in
                    DispatchQueue.main.async {
                        self.imageSubject.onNext(data)
                    }
            })
            .disposed(by: bag)
    }
}
