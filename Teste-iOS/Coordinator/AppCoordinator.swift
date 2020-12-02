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
        viewController.coordinator = self
        viewController.title = "Eventos"
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail() {
        let viewController = DetailViewController()
        viewController.coordinator = self
        viewController.title = "Nome do Evento"
        navigationController.pushViewController(viewController, animated: true)
    }
}

