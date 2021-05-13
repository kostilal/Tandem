//
//  AlbumsRouterFactory.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

protocol AlbumsFactoryProtocol {
    func createAlbumsModule(delegate: AlbumsPresenterDelegate) -> AlbumsViewController
    func createPhotosModule(albumId: Int) -> PhotosViewController
}

final class AlbumsFactory: AlbumsFactoryProtocol {
    func createAlbumsModule(delegate: AlbumsPresenterDelegate) -> AlbumsViewController {
        let controller = AlbumsViewController(loadType: .xib)
        AlbumsPresenter(controller: controller, delegate: delegate)
        return controller
    }
    
    func createPhotosModule(albumId: Int) -> PhotosViewController {
        let controller = PhotosViewController(loadType: .xib)
        PhotosPresenter(controller: controller, albumId: albumId)
        return controller
    }
}
