//
//  ViewController.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 01/12/20.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    // MARK: - Variable(s)
    let bag = DisposeBag()
    weak var coordinator: AppCoordinator?
    var viewModel: MainViewModel!
    
    
    // MARK: - UI Variable(s)
    lazy private var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.register(EventCell.self, forCellReuseIdentifier: "eventCell")
        return view
    }()
    
    lazy private var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }()
    
    override func loadView() {
        setupView()
        bindTableView()
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
        
        tableView.rx.modelSelected(Event.self)
            .subscribe(onNext: { event in
                self.coordinator?.showDetail(with: event.title)
            }).disposed(by: bag)
        
        viewModel.isReady
            .subscribe(
                onNext: { isReady in
                    if isReady {
                        self.indicator.stopAnimating()
                        self.indicator.removeFromSuperview()
                    }
                })
            .disposed(by: bag)
            
    }

}

extension MainViewController: ViewCode {
    func buildViewHierarchy() {
        view = UIView(frame: .zero)
        view.addSubview(tableView)
        view.addSubview(indicator)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        indicator.snp.makeConstraints { (make) in
            make.center.equalTo(view.safeAreaLayoutGuide.snp.center)
        }
    }
    
    func additionalConfigurations() {
        view.backgroundColor = .secondarySystemBackground
    }
}
