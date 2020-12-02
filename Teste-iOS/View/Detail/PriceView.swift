//
//  PriceView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class PriceView: UIView {
    
    // MARK: - Variable(s)
    lazy var priceLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Preço: "
        return view
    }()
    
    lazy var priceInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.text = "R$ 7,00"
        return view
    }()
    
    lazy var hStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    
    // MARK: - Init(s)
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Code Extension
extension PriceView: ViewCode {
    func buildViewHierarchy() {
        hStack.addArrangedSubview(priceLabel)
        hStack.addArrangedSubview(priceInfoLabel)
        addSubview(hStack)
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func additionalConfigurations() {
        
    }
}

