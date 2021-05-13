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
    
    // MARK: Life cycle
    @discardableResult init(controller: AlbumsViewControllerProtocol, delegate: AlbumsPresenterDelegate) {
        self.controller = controller
        self.delegate = delegate
        self.controller?.presenter = self
    }
}

extension AlbumsPresenter: AlbumsPresenterProtocol {
    func onViewDidLoad() {
        controller?.set(title: "Albums")
        controller?.showLoadingController()
        
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
        controller?.hideLoadingController()
        controller?.show(albums: [AlbumsViewModel(title: "Хуй нахуй"),
                                  AlbumsViewModel(title: "Нахуй хуй")])
        
//        swags = SwagListModels.mockSwags
//
//        let vm = SwagListFormatter.convert(swags)
//        controller?.show(swags: vm)
    }
}
