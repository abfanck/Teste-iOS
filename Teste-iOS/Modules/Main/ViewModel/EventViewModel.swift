//
//  EventViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import Foundation
import RxSwift

class EventViewModel {
    
    // MARK: - Public Variable(s)
    
    var imageSubject = BehaviorSubject<Data?>(value: nil)
    var titleSubject: BehaviorSubject<String>
    
    
    // MARK: - Private Variable(s)
    
    private let bag = DisposeBag()
    private let imageURL: URL
    
    
    // MARK: - Init
    
    init(title: String, imageURL: URL) {
        self.imageURL = imageURL
        self.titleSubject = BehaviorSubject<String>(value: title)
        self.getImageData()
    }
    
    
    // MARK: - API Request
    
    func getImageData() {
        APIService.getDataFrom(url: imageURL)
            .subscribe(
                onNext: { data in
                    DispatchQueue.main.async {
                        self.imageSubject.onNext(data)
                        self.imageSubject.onCompleted()
                    }
                },
                onError: { (error) in
                    DispatchQueue.main.async {
                        self.imageSubject.onError(error)
                    }
                })
            .disposed(by: bag)
    }
    
}
