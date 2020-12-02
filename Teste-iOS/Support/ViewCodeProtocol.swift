//
//  ViewCodeProtocol.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import Foundation
import SnapKit

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func additionalConfigurations()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalConfigurations()
    }
}

