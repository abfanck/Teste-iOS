//
//  EventImageViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import Foundation
import RxSwift

class EventImageViewModel {
    
    // MARK: - Public Variable(s)
    
    var imageSubject = BehaviorSubject<Data?>(value: nil)
    
    
    // MARK: - Private Variable(s)
    
    private let apiService = APIService.shared
    private let bag = DisposeBag()
    private let imageURL: URL
    
    
    // MARK: - Init
    
    init(imageURL: URL) {
        self.imageURL = imageURL
        getImageData()
    }
    
    
    // MARK: - API Request
    
    func getImageData() {
        apiService.getDataFrom(url: imageURL)
            .subscribe(
                onNext: { data in
                    DispatchQueue.main.async {
                        self.imageSubject.onNext(data)
                        self.imageSubject.onCompleted()
                    }
                }, onError: { (error) in
                    DispatchQueue.main.async {
                        self.imageSubject.onError(error)
                    }
                })
            .disposed(by: bag)
    }
}
