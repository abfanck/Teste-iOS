//
//  DescriptionView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class DescriptionView: UIView {
    
    // MARK: - Variable(s)
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
        view.text = """
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksj akdjlak skldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjd asdjakdjlakjdkasldjas djaskldjaskldjas
            djasdjalksjdjasdjakdjl askldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldj skldjaskldjas
            djasdjalksjdjasdjakd askldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djas sjdjasdja akjdkasldj askldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasd asdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasd lakjdkasld ldjaskld askldjas
            djasdjalksj jakdjlakjdk askldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlak djaskldjaskldjaskldjas
            djasdjalk jasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlak skldjaskldjaskldjas
            djasdjal jlakjdka jaskldj djask djas
            djasdjalk asdjak akjdkasldjaskldjaskld kldjas
            djasdjalksjdjasdjakdjlakj ldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjasdjakdjlakjdkasldjaskldjaskldjaskldjas
            djasdjalksjdjas askldjaskldjaskldjas
            djasdjalk akjdkasldjaskldjas kldjas
            djasd sjdjas akd dkasldj kldjaskldjas
            djasdjalksjdjasdj sldjaskldjaskldjaskldjas
            """
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
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

