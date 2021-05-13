//
//  AlbumsFormatter.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

final class AlbumsFormatter {
    static func convert(_ album: Album) -> AlbumsViewModel {
        return AlbumsViewModel(title: album.title)
    }
    
    static func convert(_ albums: [Album]) -> [AlbumsViewModel] {
        return albums.map({convert($0)})
    }
}
