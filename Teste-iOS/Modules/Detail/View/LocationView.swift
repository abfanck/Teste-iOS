//
//  LocationView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit
import RxSwift

class LocationView: UIView {
    
    // MARK: - Variable(s)
    
    var viewModel: LocationViewModel
    private let bag = DisposeBag()
    
    
    // MARK: - UI Variable(s)
    
    lazy private var locationLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Localização: "
        return view
    }()
    
    lazy private var locationInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    lazy private var vStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 6
        return view
    }()
    
    
    // MARK: - Init(s)
    
    init(frame: CGRect = .zero, viewModel: LocationViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
        bindData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Binding Data with UI
    
    func bindData() {
        viewModel.locationFormatted
            .bind(to: locationInfoLabel.rx.text)
            .disposed(by: bag)
    }
}


// MARK: - View Code Extension

extension LocationView: ViewCode {
    func buildViewHierarchy() {
        vStack.addArrangedSubview(locationLabel)
        vStack.addArrangedSubview(locationInfoLabel)
        addSubview(vStack)
    }
    
    func setupConstraints() {
        vStack.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func additionalConfigurations() {
        
    }
}

