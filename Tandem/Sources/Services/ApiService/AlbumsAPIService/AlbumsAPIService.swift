//
//  CitiesApiService.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

protocol AlbumsAPIServiceProtocol {
    func fetchAlbums(completion: @escaping Completion<Result<[Album], WebError>>)
}

final class AlbumsAPIService: AlbumsAPIServiceProtocol {
    func fetchAlbums(completion: @escaping Completion<Result<[Album], WebError>>) {
        guard let url = URL(string: Constants.API.baseUrl + Constants.API.albums) else {
            completion(.failure(WebError(description: "Not valid url")))
            return
        }
        
        let data = APIService.RequestData(url: url,method: .get)
        
        APIService.requestData(data: data) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let cities = try decoder.decode([Album].self, from: data)
                    completion(.success(cities))
                } catch {
                    completion(.failure(WebError(description: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
