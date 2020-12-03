//
//  DetailViewController.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var viewModel: DetailViewModel!
    
    override func loadView() {
        let view = DetailView(viewModel: viewModel)
        self.view = view
    }
}

