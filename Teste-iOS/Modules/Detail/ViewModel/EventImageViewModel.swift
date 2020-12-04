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
    
    private let bag = DisposeBag()
    
    
    // MARK: - Init
    
    init(imageURL: PublishSubject<URL>) {
        imageURL
            .subscribe(
                onNext: { [weak self] (url) in
                    self?.getImageData(from: url)
                })
            .disposed(by: bag)
    }
    
    
    // MARK: - API Request
    
    func getImageData(from url: URL) {
        APIService.getDataFrom(url: url)
            .subscribe(
                onNext: { [weak self] data in
                    DispatchQueue.main.async {
                        self?.imageSubject.onNext(data)
                        self?.imageSubject.onCompleted()
                    }
                }, onError: { [weak self] (error) in
                    DispatchQueue.main.async {
                        self?.imageSubject.onError(error)
                    }
                })
            .disposed(by: bag)
    }
}
