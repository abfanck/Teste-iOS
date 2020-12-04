//
//  DetailViewController.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    // MARK: - Variable(s)
    
    private let bag = DisposeBag()
    weak var coordinator: AppCoordinator?
    var viewModel: DetailViewModel!
    
    
    // MARK: - Init(s)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Enviar", style: .plain, target: self, action: #selector(sendAction))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Loading View
    
    override func loadView() {
        let view = DetailView(viewModel: viewModel)
        self.view = view
        self.bindData()
    }
    
    
    // MARK: - Binding Data with UI
    
    func bindData() {
        viewModel.showAlert
            .subscribe(
                onNext: { (showAlert) in
                    if showAlert {
                        DispatchQueue.main.async {
                            self.showCheckInAlert()
                        }
                    }
                })
            .disposed(by: bag)
    }
    
    
    // MARK: - Alert Function(s)
    
    func showCheckInAlert() {
        let alertController = UIAlertController(title: "Confirme sua presença", message: "Quase lá! Informe seus dados:", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in
            if let nameTxtField = alertController.textFields?[0], let name = nameTxtField.text,
               let emailTxtField = alertController.textFields?[1], let email = emailTxtField.text {
                
                let result = self.viewModel.convertToData(name: name, email: email)
                switch result {
                case .success(let data):
                    APIService.saveCheckIn(data) { (error) in
                        DispatchQueue.main.async {
                            self.showResultAlert(for: error)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showResultAlert(for: error)
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Nome"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "E-mail"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func showResultAlert(for error: Error?) {
        let title = (error == nil) ? "Sua presença foi salva!" : "Não possível salvar sua presença!"
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in}
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    
    // MARK: - Action
    
    // Action to send event information
    @objc func sendAction() {
        let textToShare = [viewModel.eventTitle, viewModel.eventDescription]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

