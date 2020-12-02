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
        //self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.prefersLargeTitles = false
    }
    
    func start() {
        let viewController = DetailViewController()
        viewController.coordinator = self
        viewController.title = "Eventos"
        navigationController.pushViewController(viewController, animated: true)
    }
}

