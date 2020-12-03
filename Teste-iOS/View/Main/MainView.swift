//
//  MainView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit
import RxSwift
import RxCocoa

class MainView: UIView {
    
    var viewModel: MainViewModel
    let bag = DisposeBag()
    // MARK: - Variable(s)
    
    lazy private var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.register(EventCell.self, forCellReuseIdentifier: "eventCell")
        return view
    }()
    
    // MARK: - Init(s)
    
    override init(frame: CGRect = .zero) {
        viewModel = MainViewModel()
        super.init(frame: frame)
        setupView()
        
        bindTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindTableView() {
        viewModel.events
            .bind(to: tableView.rx.items(cellIdentifier: "eventCell", cellType: EventCell.self)) { (_, event, cell) in
                cell.eventTitle = event.title
                self.viewModel.getImageData(from: event.imageURL)
                    .bind(to: cell.rx.imageData)
                    .disposed(by: self.bag)
            }
            .disposed(by: bag)
    }
}

// MARK: - View Code Extension

extension MainView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func additionalConfigurations() {
        backgroundColor = .secondarySystemBackground
    }
}
