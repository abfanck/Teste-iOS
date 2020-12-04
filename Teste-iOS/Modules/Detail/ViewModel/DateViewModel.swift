//
//  DateViewModel.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import Foundation
import RxSwift

class DateViewModel {
    
    // MARK: - Public Variable(s)
    
    var dayFormatted = BehaviorSubject<String>(value: "")
    var timeFormatted = BehaviorSubject<String>(value: "")
    
    
    // MARK: - Private Variable(s)
    
    private let bag = DisposeBag()
    
    
    // MARK: - Init
    
    init(date: PublishSubject<Date>) {
        date
            .subscribe(
                onNext: { (date) in
                    self.formatDay(from: date)
                    self.formatTime(from: date)
                })
            .disposed(by: bag)
    }
    
    
    // MARK: - Formating Function(s)
    
    private func formatDay(from date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "pt-BR")
        let day = dateFormatter.string(from: date)
        self.dayFormatted.onNext(day)
    }
    
    private func formatTime(from date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "pt-BR")
        let time = dateFormatter.string(from: date)
        self.timeFormatted.onNext(time)
    }
}
