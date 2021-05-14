//
//  PhotosViewController.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

protocol PhotosViewControllerProtocol: BaseViewControllerProtocol {
    var presenter: BasePresenterProtocol? { get set }
    
    func show(photos: [PhotosViewModel])
}

class PhotosViewController: BaseViewController {
    var presenter: BasePresenterProtocol?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var data: [PhotosViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareCollectionsView()
        presenter?.onViewDidLoad()
    }
}

extension PhotosViewController: PhotosViewControllerProtocol {
    func show(photos: [PhotosViewModel]) {
        data = photos
        collectionView.reloadData()
    }
}

private extension PhotosViewController {
    // MARK: Private methods
    func prepareCollectionsView() {
        collectionView.dataSource = self
        collectionView.register(cellType: PhotosCollectionCell.self)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: PhotosCollectionCell.self, for: indexPath)
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
}
