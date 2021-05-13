//
//  AlbumsRouterFactory.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

protocol AlbumsFactoryProtocol {
    func createAlbumsModule(delegate: AlbumsPresenterDelegate) -> AlbumsViewController
}

final class AlbumsFactory: AlbumsFactoryProtocol {
    func createAlbumsModule(delegate: AlbumsPresenterDelegate) -> AlbumsViewController {
        let controller = AlbumsViewController(loadType: .xib)
        AlbumsPresenter(controller: controller, delegate: delegate)
        return controller
    }
}
