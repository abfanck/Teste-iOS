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
    
    private var price: Float
    
    
    // MARK: - Init
    
    init(price: Float) {
        self.price = price
        self.formatPrice()
    }
    
    
    // MARK: - Formating Function(s)
    
    func formatPrice() {
        let price: String = String(format: "R$ %.2f", self.price).replacingOccurrences(of: ".", with: ",")
        self.priceFormatted.onNext(price)
    }
}
