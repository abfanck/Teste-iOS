//
//  DescriptionView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit
import RxSwift

class DescriptionView: UIView {
    
    // MARK: - Variable(s)
    
    private let bag = DisposeBag()
    private var eventDescription: PublishSubject<String>
    
    
    // MARK: - UI Variable(s)
    
    lazy private var descriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Descrição"
        return view
    }()
    
    lazy private var descriptionInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .justified
        return view
    }()
    
    lazy private var vStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 12
        return view
    }()
    
    
    // MARK: - Init(s)
    
    init(frame: CGRect = .zero, description: PublishSubject<String>) {
        self.eventDescription = description
        super.init(frame: frame)
        setupView()
        bindData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding Data with UI
    
    func bindData() {
        self.eventDescription
            .bind(to: descriptionInfoLabel.rx.text)
            .disposed(by: bag)
    }
}


// MARK: - View Code Extension

extension DescriptionView: ViewCode {
    func buildViewHierarchy() {
        vStack.addArrangedSubview(descriptionLabel)
        vStack.addArrangedSubview(descriptionInfoLabel)
        addSubview(vStack)
    }
    
    func setupConstraints() {
        vStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func additionalConfigurations() {
        
    }
}

