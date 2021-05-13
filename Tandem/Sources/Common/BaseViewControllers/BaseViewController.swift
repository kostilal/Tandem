//
//  BaseViewController.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

protocol BaseViewControllerProtocol: class {
    var loadingController: LoadingViewController? { get set }
    
    func set(title: String)
    func showLoadingController()
    func hideLoadingController()
    func showAlert(title: String?, message: String?)
}

class BaseViewController: UIViewController {
    var loadingController: LoadingViewController?
    
    enum LoadType {
        case programmatically
        case xib
        case xibName(String)
    }
    
    // MARK: Life cycle
    init(loadType: LoadType = .xib) {
        var nibName: String
        
        switch loadType {
        case .programmatically:
            super.init(nibName: nil, bundle: nil)
            return
        case .xib:
            nibName = type(of: self).className
        case let .xibName(name):
            nibName = name
        }
        
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension BaseViewController: BaseViewControllerProtocol {
    // MARK: ViewController title configuration
    func set(title: String) {
        self.title = title
    }
    
    // MARK: Default alert methods
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(ok)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Loading animation methods
    func showLoadingController() {
        showLoadingController(on: self, view: self.view)
    }
    
    func hideLoadingController() {
        loadingController?.removeFromParentController()
        loadingController = nil
    }
}

private extension BaseViewController {
    // MARK: Private methods
    func showLoadingController(on controller: UIViewController, view: UIView) {
        loadingController = LoadingViewController()
        controller.add(childViewController: loadingController!, to: view)
    }
}
