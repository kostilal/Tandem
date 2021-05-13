//
//  AlbumsRouter.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

final class AlbumsRouter {
    private let navController: UINavigationController
    private let albumsFactory: AlbumsFactoryProtocol
    
    // MARK: Life cycle
    init(navController: UINavigationController, albumsFactory: AlbumsFactoryProtocol = AlbumsFactory()) {
        self.navController = navController
        self.albumsFactory = albumsFactory
        
        let controller = albumsFactory.createAlbumsModule(delegate: self)
        navController.viewControllers = [controller]
    }
}

extension AlbumsRouter: AlbumsPresenterDelegate {
    func presenter(_ presenter: AlbumsPresenterProtocol, didSelect album: Album) {
        let controller = albumsFactory.createPhotosModule(albumId: album.id)
        navController.pushViewController(controller, animated: true)
    }
}
