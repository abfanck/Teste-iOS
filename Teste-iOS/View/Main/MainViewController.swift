//
//  ViewController.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 01/12/20.
//

import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    override func loadView() {
        let view = MainView()
        self.view = view
    }

}
