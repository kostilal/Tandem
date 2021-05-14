//
//  AlbumsRouterFactory.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

protocol AlbumsFactoryProtocol {
    func createAlbumsModule(delegate: AlbumsPresenterDelegate) -> AlbumsViewController
    func createPhotosModule(album: Album) -> PhotosViewController
}

final class AlbumsFactory: AlbumsFactoryProtocol {
    func createAlbumsModule(delegate: AlbumsPresenterDelegate) -> AlbumsViewController {
        let controller = AlbumsViewController(loadType: .xib)
        AlbumsPresenter(controller: controller, delegate: delegate)
        return controller
    }
    
    func createPhotosModule(album: Album) -> PhotosViewController {
        let controller = PhotosViewController(loadType: .xib)
        PhotosPresenter(controller: controller, album: album)
        return controller
    }
}
