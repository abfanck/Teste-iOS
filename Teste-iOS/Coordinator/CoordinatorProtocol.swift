//
//  CoordinatorProtocol.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
