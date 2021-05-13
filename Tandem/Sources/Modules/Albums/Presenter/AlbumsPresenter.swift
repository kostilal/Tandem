//
//  AlbumsPresenter.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

protocol AlbumsPresenterProtocol: BasePresenterProtocol {
    func onSelectAlbum(with index: Int)
}

protocol AlbumsPresenterDelegate: AnyObject {
    func presenter(_ presenter: AlbumsPresenterProtocol, didSelect album: Album)
}

final class AlbumsPresenter {
    private weak var delegate: AlbumsPresenterDelegate?
    private weak var controller: AlbumsViewControllerProtocol?
    private var albums: [Album] = []
    private let networkSevice: AlbumsAPIServiceProtocol
    
    // MARK: Life cycle
    @discardableResult init(controller: AlbumsViewControllerProtocol,
                            delegate: AlbumsPresenterDelegate,
                            networkSevice: AlbumsAPIServiceProtocol = AlbumsAPIService()) {
        self.controller = controller
        self.delegate = delegate
        self.networkSevice = networkSevice
        self.controller?.presenter = self
    }
}

extension AlbumsPresenter: AlbumsPresenterProtocol {
    func onViewDidLoad() {
        controller?.set(title: "Albums")
        fetchAlbums()
    }
    
    func onSelectAlbum(with index: Int) {
        guard albums.indices.contains(index) else { return }
        
        delegate?.presenter(self, didSelect: albums[index])
    }
}

private extension AlbumsPresenter {
    // MARK: Private methods
    func fetchAlbums() {
        controller?.showLoadingController()
        networkSevice.fetchAlbums {[weak self] (result) in
            guard let self = self else { return }
            async {
                self.controller?.hideLoadingController()
                switch result {
                case .success(let albums):
                    self.albums = albums
                    let vm = AlbumsFormatter.convert(albums)
                    self.controller?.show(albums: vm)
                case .failure(let error):
                    self.controller?.showAlert(title: "Error", message: error.description)
                }
            }
        }
    }
}
