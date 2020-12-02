//
//  DetailView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class DetailView: UIView {
    
    lazy var dateView = DateView()
    lazy var descriptionView = DescriptionView()
    lazy var locationView = LocationView()
    lazy var priceView = PriceView()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(systemName: "photo.fill")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: bounds)
        return view
    }()
    
    lazy var overallVStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    lazy var infoVStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 18
        return view
    }()
    
    lazy var dateAndPriceVStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 6
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
extension DetailView: ViewCode {
    func buildViewHierarchy() {
        dateAndPriceVStack.addArrangedSubview(dateView)
        dateAndPriceVStack.addArrangedSubview(priceView)
        dateAndPriceVStack.addArrangedSubview(locationView)
        infoVStack.addArrangedSubview(dateAndPriceVStack)
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
            make.edges.equalToSuperview()
            make.width.equalTo(snp.width)
            make.height.greaterThanOrEqualTo(snp.height)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(overallVStack.snp.width)
            make.height.equalTo(imageView.snp.width).dividedBy(1.5)
        }
        
        infoVStack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().inset(25)
        }
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
        scrollView.backgroundColor = .orange
        infoVStack.backgroundColor = .white
        imageView.backgroundColor = .red
    }
}

