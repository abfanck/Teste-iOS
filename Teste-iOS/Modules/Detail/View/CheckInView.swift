//
//  CheckInView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 04/12/20.
//

import UIKit
import RxSwift

class CheckInView: UIView {
    
    // MARK: - Variable(s)
    
    let showAlert: BehaviorSubject<Bool>
    
    // MARK: - UI Variable(s)
    
    lazy var checkButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        view.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .highlighted)
        view.imageView?.contentMode = .scaleAspectFit
        view.imageView?.clipsToBounds = true
        let action = UIAction(title: "showAlert") { (_) in
            self.showAlert.onNext(true)
        }
        view.addAction(action, for: .primaryActionTriggered)
        return view
    }()
    
    lazy var checkLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.text = "Marque sua presença!"
        return view
    }()
    
    lazy var hStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 6
        return view
    }()
    
    
    // MARK: - Init(s)
    
    init(frame: CGRect = .zero, showAlert: BehaviorSubject<Bool>) {
        self.showAlert = showAlert
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - View Code Extension

extension CheckInView: ViewCode {
    func buildViewHierarchy() {
        hStack.addArrangedSubview(checkButton)
        hStack.addArrangedSubview(checkLabel)
        addSubview(hStack)
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        checkButton.imageView?.snp.makeConstraints { (make) in
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
    }
    
    func additionalConfigurations() {
        
    }
}

