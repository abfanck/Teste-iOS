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
    
    weak var coordinator: AppCoordinator?
    var viewModel: MainViewModel!
    private let bag = DisposeBag()
    
    
    // MARK: - UI Variable(s)
    
    lazy private var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.register(EventViewCell.self, forCellReuseIdentifier: "eventCell")
        return view
    }()
    
    lazy private var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }()
    
    
    // MARK: - Loading View
    
    override func loadView() {
        setupView()
        bindData()
    }
    
    
    // MARK: - Binding Data with UI
    
    func bindData() {
        viewModel.events
            .bind(to: tableView.rx.items(cellIdentifier: "eventCell", cellType: EventViewCell.self)) { (_, event, cell) in
                cell.viewModel = EventViewModel(title: event.title, imageURL: event.imageURL)
            }
            .disposed(by: bag)
        
        tableView.rx.modelSelected(Evento.self)
            .subscribe(
                onNext: { [weak self] event in
                    self?.coordinator?.showDetailForEvent(withId: event.id, title: event.title)
            })
            .disposed(by: bag)
        
        viewModel.isReady
            .subscribe(
                onNext: { [weak self] isReady in
                    if isReady {
                        self?.indicatorView.stopAnimating()
                        self?.indicatorView.removeFromSuperview()
                    }
                })
            .disposed(by: bag)
    }
}


// MARK: - View Code Extension

extension MainViewController: ViewCode {
    func buildViewHierarchy() {
        view = UIView(frame: .zero)
        view.addSubview(tableView)
        view.addSubview(indicatorView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(view.safeAreaLayoutGuide.snp.center)
        }
    }
    
    func additionalConfigurations() {
        view.backgroundColor = .secondarySystemBackground
    }
}
