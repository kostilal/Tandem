//
//  AppRouter.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

final class AppRouter {
    private let navController: UINavigationController
    private var albumsRouter: AlbumsRouter?
    
    // MARK: Life cycle
    init(navController: UINavigationController) {
        self.navController = navController
        
        showInitialFlow()
    }
}

private extension AppRouter {
    // MARK: Private methods
    func showInitialFlow() {
        albumsRouter = AlbumsRouter(navController: navController)
    }
}
