//
//  DateView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class DateView: UIView {
    
    // MARK: - Variable(s)
    lazy var dayLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Dia: "
        return view
    }()
    
    lazy var dayInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.text = "18/12/2020"
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Horário: "
        return view
    }()
    
    lazy var timeInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.text = "17:30"
        return view
    }()
    
    lazy var dayHStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .leading
        return view
    }()
    
    lazy var timeHStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .leading
        return view
    }()
    
    lazy var overallHStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .leading
        view.spacing = 18
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
extension DateView: ViewCode {
    func buildViewHierarchy() {
        dayHStack.addArrangedSubview(dayLabel)
        dayHStack.addArrangedSubview(dayInfoLabel)
        timeHStack.addArrangedSubview(timeLabel)
        timeHStack.addArrangedSubview(timeInfoLabel)
        overallHStack.addArrangedSubview(dayHStack)
        overallHStack.addArrangedSubview(timeHStack)
        addSubview(overallHStack)
    }
    
    func setupConstraints() {
        overallHStack.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        timeInfoLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(overallHStack.snp.trailing)
        }
    }
    
    func additionalConfigurations() {
        
    }
}

