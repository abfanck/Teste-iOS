//
//  DateView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit
import RxSwift

class DateView: UIView {
    
    // MARK: - Variable(s)
    
    var viewModel: DateViewModel
    private var bag = DisposeBag()
    
    
    // MARK: - UI Variable(s)
    
    lazy private var dayLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Dia: "
        return view
    }()
    
    lazy private var dayInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return view
    }()
    
    lazy private var timeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "Horário: "
        return view
    }()
    
    lazy private var timeInfoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return view
    }()
    
    lazy private var dayHStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .leading
        return view
    }()
    
    lazy private var timeHStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .leading
        return view
    }()
    
    lazy private var overallVStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 6
        return view
    }()
    
    
    // MARK: - Init(s)
    
    init(frame: CGRect = .zero, viewModel: DateViewModel) {
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
        viewModel.dayFormatted
            .bind(to: dayInfoLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.timeFormatted
            .bind(to: timeInfoLabel.rx.text)
            .disposed(by: bag)
    }
}


// MARK: - View Code Extension

extension DateView: ViewCode {
    func buildViewHierarchy() {
        dayHStack.addArrangedSubview(dayLabel)
        dayHStack.addArrangedSubview(dayInfoLabel)
        timeHStack.addArrangedSubview(timeLabel)
        timeHStack.addArrangedSubview(timeInfoLabel)
        overallVStack.addArrangedSubview(dayHStack)
        overallVStack.addArrangedSubview(timeHStack)
        addSubview(overallVStack)
    }
    
    func setupConstraints() {
        overallVStack.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        timeInfoLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(overallVStack.snp.trailing)
        }
    }
    
    func additionalConfigurations() {
        
    }
}

