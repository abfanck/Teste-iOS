//
//  SceneDelegate.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 01/12/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var coordinator: AppCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        
        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

