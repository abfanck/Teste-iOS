//
//  AppCoordinator.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let viewController = MainViewController()
        viewController.viewModel = MainViewModel()
        viewController.coordinator = self
        viewController.title = "Eventos"
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail(for event: Event) {
        let viewController = DetailViewController()
        viewController.viewModel = DetailViewModel(event: event)
        viewController.coordinator = self
        viewController.title = event.title
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(viewController, animated: true)
    }
}

