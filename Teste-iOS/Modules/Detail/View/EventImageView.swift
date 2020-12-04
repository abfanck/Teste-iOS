//
//  EventImageView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 03/12/20.
//

import UIKit
import RxSwift

class EventImageView: UIView {
    
    // MARK: - Variable(s)
    let viewModel: EventImageViewModel
    private let bag = DisposeBag()
    
    // MARK: - UI Variable(s)
    
    lazy private var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy private var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }()
    
    
    // MARK: - Init(s)
    
    init(frame: CGRect = .zero, viewModel: EventImageViewModel) {
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
        viewModel.imageSubject
            .subscribe(
                onNext: { (data) in
                    if let data = data {
                        self.imageView.image = UIImage(data: data)
                    }
                }, onError: { (_) in
                    self.imageView.backgroundColor = .darkGray
                }, onDisposed: {
                    self.indicatorView.stopAnimating()
                    self.indicatorView.removeFromSuperview()
                })
            .disposed(by: bag)
    }
}


// MARK: - View Code Extension

extension EventImageView: ViewCode {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(indicatorView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
        }
    }
    
    func additionalConfigurations() {
        
    }
}

