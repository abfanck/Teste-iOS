//
//  DetailViewController.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    override func loadView() {
        let view = DetailView()
        self.view = view
    }
}

