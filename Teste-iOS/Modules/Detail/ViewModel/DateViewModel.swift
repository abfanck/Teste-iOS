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
    
    private var date: Date
    
    
    // MARK: - Init
    
    init(date: Date) {
        self.date = date
        self.formatDay()
        self.formatTime()
    }
    
    
    // MARK: - Formating Function(s)
    
    private func formatDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "pt-BR")
        let day = dateFormatter.string(from: date)
        self.dayFormatted.onNext(day)
    }
    
    private func formatTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "pt-BR")
        let time = dateFormatter.string(from: date)
        self.timeFormatted.onNext(time)
    }
}
