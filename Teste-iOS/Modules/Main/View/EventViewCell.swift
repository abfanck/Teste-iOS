//
//  EventCell.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit
import RxSwift

class EventViewCell: UITableViewCell {
    
    // MARK: - Variable(s)
    
    private let bag = DisposeBag()
    
    var viewModel: EventViewModel? {
        didSet {
            bindData()
        }
    }
    
    
    // MARK: - UI Variable(s)
    
    lazy private var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }()
    
    lazy private var eventImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy private var eventLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    lazy private var hStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 10
        return view
    }()
    
    
    // MARK: - Init(s)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Binding Data with UI
    
    func bindData() {
        viewModel?.titleSubject
            .bind(to: eventLabel.rx.text)
            .disposed(by: bag)
        
        viewModel?.imageSubject
            .subscribe(
                onNext: { data in
                    if let data = data {
                        self.eventImageView.image = UIImage(data: data)
                        self.eventImageView.backgroundColor = .clear
                    }
                },
                onError: { (_) in
                    self.eventImageView.backgroundColor = .darkGray
                },
                onDisposed: {
                    self.indicatorView.stopAnimating()
                    self.indicatorView.removeFromSuperview()
                })
            .disposed(by: bag)
    }
}


// MARK: - View Code Extension

extension EventViewCell: ViewCode {
    func buildViewHierarchy() {
        eventImageView.addSubview(indicatorView)
        hStack.addArrangedSubview(eventImageView)
        hStack.addArrangedSubview(eventLabel)
        contentView.addSubview(hStack)
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalTo(contentView.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(contentView.safeAreaLayoutGuide.snp.right).inset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.height.equalTo(eventImageView.snp.height)
        })
        
        eventImageView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(eventImageView.snp.height).multipliedBy(1.2)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func additionalConfigurations() {
        self.selectionStyle = .none
        hStack.backgroundColor = .systemFill
        hStack.layer.cornerRadius = 18
        hStack.clipsToBounds = true
    }
}

