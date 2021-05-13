//
//  PhotosAPIService.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

protocol PhotosAPIServiceProtocol {
    func fetchPhotos(albumId: Int, completion: @escaping Completion<Result<[Photo], WebError>>)
}

final class PhotosAPIService: PhotosAPIServiceProtocol {
    func fetchPhotos(albumId: Int, completion: @escaping Completion<Result<[Photo], WebError>>) {
        guard let url = URL(string: Constants.API.baseUrl + Constants.API.photos) else {
            completion(.failure(WebError(description: "Not valid url")))
            return
        }
        
        let data = APIService.RequestData(url: url, method: .get, parameters: ["albumId": albumId])
        
        APIService.requestData(data: data) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let photos = try decoder.decode([Photo].self, from: data)
                    completion(.success(photos))
                } catch {
                    completion(.failure(WebError(description: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
