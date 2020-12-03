//
//  PriceView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit
import RxSwift

class PriceView: UIView {
    
    // MARK: - Variable(s)
    
    var viewModel: PriceViewModel
    private let bag = DisposeBag()
    
    
    // MARK: - UI Variable(s)
    
    lazy private var priceLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Preço: "
        return view
    }()
    
    lazy private var priceInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return view
    }()
    
    lazy private var hStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    
    
    // MARK: - Init(s)
    
    init(frame: CGRect = .zero, viewModel: PriceViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
        bindData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Binding Data with UI
    
    func bindData()  {
        viewModel.priceFormatted
            .bind(to: priceInfoLabel.rx.text)
            .disposed(by: bag)
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
