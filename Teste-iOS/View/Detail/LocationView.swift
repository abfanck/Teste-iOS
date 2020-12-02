//
//  LocationView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class LocationView: UIView {
    
    // MARK: - Variable(s)
    
    lazy var locationLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Localização: "
        return view
    }()
    
    lazy var locationInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.text = "Parque Farroupilha"
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
extension LocationView: ViewCode {
    func buildViewHierarchy() {
        hStack.addArrangedSubview(locationLabel)
        hStack.addArrangedSubview(locationInfoLabel)
        addSubview(hStack)
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func additionalConfigurations() {
        
    }
}

