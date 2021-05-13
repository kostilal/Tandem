//
//  BaseNavigationController.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

class BaseNavigationController: UINavigationController {
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        applyTheme()
    }
}

private extension BaseNavigationController {
    // MARK: Private methods
    private func applyTheme() {
        let fontColor = UIColor.white
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.main
        self.navigationBar.tintColor = fontColor
        self.navigationBar.titleTextAttributes = [.foregroundColor: fontColor]
    }
}
