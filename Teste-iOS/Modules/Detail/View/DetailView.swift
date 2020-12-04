//
//  DetailView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Variable(s)
    
    private var viewModel: DetailViewModel
    
    
    // MARK: - UI Variable(s)
    
    lazy private var dateView: DateView = {
        let viewModel = DateViewModel(date: self.viewModel.date)
        let view = DateView(viewModel: viewModel)
        return view
    }()
    
    lazy private var descriptionView: DescriptionView = {
        let view = DescriptionView(description: self.viewModel.description)
        return view
    }()
    
    lazy private var locationView: LocationView = {
        let viewModel = LocationViewModel(latitude: self.viewModel.latitude, longitude: self.viewModel.longitude)
        let view = LocationView(viewModel: viewModel)
        return view
    }()
    
    lazy private var priceView: PriceView = {
        let viewModel = PriceViewModel(price: self.viewModel.price)
        let view = PriceView(viewModel: viewModel)
        return view
    }()
    
    lazy private var imageView: EventImageView = {
        let viewModel = EventImageViewModel(imageURL: self.viewModel.imageURL)
        let view = EventImageView(viewModel: viewModel)
        return view
    }()
    
    lazy private var scrollView: UIScrollView = {
        let view = UIScrollView(frame: bounds)
        return view
    }()
    
    lazy private var overallVStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    lazy private var infoVStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 18
        return view
    }()
    
    lazy private var localHStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .leading
        view.spacing = 12
        return view
    }()
    
    lazy private var dateAndPriceVStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 6
        return view
    }()
    
    
    // MARK: - Init(s)
    
    init(frame: CGRect = .zero, viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - View Code Extension

extension DetailView: ViewCode {
    func buildViewHierarchy() {
        dateAndPriceVStack.addArrangedSubview(dateView)
        dateAndPriceVStack.addArrangedSubview(priceView)
        localHStack.addArrangedSubview(dateAndPriceVStack)
        localHStack.addArrangedSubview(locationView)
        infoVStack.addArrangedSubview(localHStack)
        infoVStack.addArrangedSubview(descriptionView)
        overallVStack.addArrangedSubview(imageView)
        overallVStack.addArrangedSubview(infoVStack)
        scrollView.addSubview(overallVStack)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
        
        overallVStack.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(25)
            make.width.equalTo(snp.width)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(overallVStack.snp.width)
            make.height.equalTo(imageView.snp.width).dividedBy(1.5)
        }
        
        infoVStack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().inset(25)
        }
        
        localHStack.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func additionalConfigurations() {
        backgroundColor = .secondarySystemBackground
    }
}

