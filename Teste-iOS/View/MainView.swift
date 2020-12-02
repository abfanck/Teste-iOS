//
//  MainView.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class MainView: UIView {
    
    // MARK: - Variable(s)
    
    lazy private var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(EventCell.self, forCellReuseIdentifier: "eventCell")
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

// MARK: - TableView Delegate and DataSource

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        
        cell.eventLabel.text = "Text \(indexPath.row)"
        
        return cell
    }
}
