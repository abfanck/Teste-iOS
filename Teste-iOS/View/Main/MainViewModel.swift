//
//  MainViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import Foundation
import RxSwift

class MainViewModel {
    
    private var apiService = APIService.shared
    private var bag = DisposeBag()
    public var events: Observable<[Event]> = Observable.empty()
    public var isReady = BehaviorSubject<Bool>(value: false)
    
    init() {
        events = apiService.getEvents()
    }
    
    func getImageData(from url: URL) -> Observable<Data> {
        let observableData = apiService.getDataFrom(url: url).catchAndReturn(Data())
        
        observableData
            .subscribe(onCompleted: {
                self.isReady.onNext(true)
            }).disposed(by: bag)
        
        return observableData
    }
}
