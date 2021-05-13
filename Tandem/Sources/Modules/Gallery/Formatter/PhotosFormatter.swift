//
//  PhotosFormatter.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

final class PhotosFormatter {
    static func convert(_ photo: Photo) -> PhotosViewModel {
        return PhotosViewModel(thumbnailUrl: photo.thumbnailUrl)
    }
    
    static func convert(_ photos: [Photo]) -> [PhotosViewModel] {
        return photos.map({convert($0)})
    }
}
