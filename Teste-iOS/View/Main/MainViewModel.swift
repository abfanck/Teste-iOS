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
    
    init() {
        self.events = apiService.getEvents()
    }
    
    func getImageData(from url: URL) -> Observable<Data> {
        return apiService.getDataFrom(url: url)
            .catchAndReturn(Data())
    }
}
