//
//  PhotosCollectionCell.swift
//  Tandem
//
//  Created by Ilya Kostyukevich on 14.05.2021.
//

import UIKit

final class PhotosCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

extension PhotosCollectionCell: ConfigurableView {
    func configure(with data: PhotosViewModel) {
        imageView.image(with: data.thumbnailUrl)
    }
}
