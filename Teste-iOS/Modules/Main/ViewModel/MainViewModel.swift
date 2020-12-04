//
//  MainViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import Foundation
import RxSwift

class MainViewModel {
    
    // MARK: - Public Varible(s)
    
    var events: Observable<[Evento]> = Observable.empty()
    var isReady = BehaviorSubject<Bool>(value: false)
    
    
    // MARK: - Private Variable(s)
    
    private let apiService = APIService.shared
    private let bag = DisposeBag()
    
    
    // MARK: - Init
    
    init() {
        let eventsObservable = apiService.getEvents()
        
        self.events = eventsObservable
        
        eventsObservable
            .subscribe(
                onCompleted: {
                    self.isReady.onNext(true)
                })
            .disposed(by: bag)
    }
}
