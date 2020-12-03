//
//  EventCell.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class EventCell: UITableViewCell {
    
    // MARK: - Data Variable(s)
    var eventTitle: String? {
        didSet {
            eventLabel.text = eventTitle
        }
    }
    var imageData: Data? {
        didSet {
            if let data = imageData {
                eventImageView.image = UIImage(data: data)
                eventImageView.backgroundColor = .clear
            }
        }
    }
    
    // MARK: - UI Variable(s)
    lazy private var eventImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .darkGray
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
}

// MARK: - View Code Extension
extension EventCell: ViewCode {
    func buildViewHierarchy() {
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
    }
    
    func additionalConfigurations() {
        self.selectionStyle = .none
        hStack.backgroundColor = .systemFill
        hStack.layer.cornerRadius = 18
        hStack.clipsToBounds = true
    }
}

