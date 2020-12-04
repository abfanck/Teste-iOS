//
//  PriceViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import Foundation
import RxSwift

class PriceViewModel {
    
    // MARK: - Public Variable(s)
    
    var priceFormatted = BehaviorSubject<String>(value: "")
    
    
    // MARK: - Private Variable(s)
    
    private let bag = DisposeBag()
    
    
    // MARK: - Init
    
    init(price: PublishSubject<Float>) {
        price
            .subscribe(
                onNext: { [weak self] (price) in
                    self?.formatPrice(price)
                })
            .disposed(by: bag)
    }
    
    
    // MARK: - Formating Function(s)
    
    func formatPrice(_ price: Float) {
        let formatted = String(format: "R$ %.2f", price).replacingOccurrences(of: ".", with: ",")
        self.priceFormatted.onNext(formatted)
    }
}
