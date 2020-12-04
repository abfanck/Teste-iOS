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
    
    func showDetailForEvent(withId id: String, title: String) {
        let viewController = DetailViewController()
        viewController.viewModel = DetailViewModel(eventId: id)
        viewController.coordinator = self
        viewController.title = title
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(viewController, animated: true)
    }
}

