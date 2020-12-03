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
    
    var isReady = BehaviorSubject<Bool>(value: false)
    var imageSubject = BehaviorSubject<Data?>(value: nil)
    var titleSubject: BehaviorSubject<String>
    
    
    // MARK: - Private Variable(s)
    
    private var apiService = APIService.shared
    private let bag = DisposeBag()
    private var imageURL: URL
    
    
    // MARK: - Init
    
    init(title: String, imageURL: URL) {
        self.imageURL = imageURL
        self.titleSubject = BehaviorSubject<String>(value: title)
        self.getImageData()
    }
    
    
    // MARK: - API Request
    
    func getImageData() {
        apiService.getDataFrom(url: imageURL)
            .filter({ $0 != nil })
            .subscribe(
                onNext: { data in
                    DispatchQueue.main.async {
                        self.imageSubject.onNext(data)
                    }
                },
                onCompleted: {
                    DispatchQueue.main.async {
                        self.isReady.onNext(true)
                    }
            })
            .disposed(by: bag)
    }
    
}
