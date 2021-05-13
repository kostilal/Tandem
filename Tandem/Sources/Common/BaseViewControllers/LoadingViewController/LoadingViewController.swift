//
//  LoadingViewController.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

final class LoadingViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private let blurVeiw = BlurEffectView(intensity: Constants.Durations.loadingBlurEffect)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        blurVeiw.frame = view.bounds
    }
}

private extension LoadingViewController {
    func setupUI() {
        activityIndicator.color = UIColor.main
        activityIndicator.startAnimating()
        view.insertSubview(blurVeiw, at: 0)
    }
}
