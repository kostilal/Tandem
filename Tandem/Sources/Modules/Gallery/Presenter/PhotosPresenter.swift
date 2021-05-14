//
//  PhotosPresenter.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

final class PhotosPresenter {
    private weak var controller: PhotosViewControllerProtocol?
    private let album: Album
    private var photos: [Photo] = []
    private let networkSevice: PhotosAPIServiceProtocol
    
    // MARK: Life cycle
    @discardableResult init(controller: PhotosViewControllerProtocol,
                            album: Album,
                            networkSevice: PhotosAPIServiceProtocol = PhotosAPIService()) {
        self.controller = controller
        self.album = album
        self.networkSevice = networkSevice
        self.controller?.presenter = self
    }
}

extension PhotosPresenter: BasePresenterProtocol {
    func onViewDidLoad() {
        controller?.set(title: album.title)
        fetchAlbums()
    }
}

private extension PhotosPresenter {
    // MARK: Private methods
    func fetchAlbums() {
        controller?.showLoadingController()
        networkSevice.fetchPhotos(albumId: album.id) {[weak self] (result) in
            guard let self = self else { return }
            async {
                self.controller?.hideLoadingController()
                switch result {
                case .success(let photos):
                    self.photos = photos
                    let vm = PhotosFormatter.convert(photos)
                    self.controller?.show(photos: vm)
                case .failure(let error):
                    self.controller?.showAlert(title: "Error", message: error.description)
                }
            }
        }
    }
}
