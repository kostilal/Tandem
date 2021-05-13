//
//  APIService.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

struct WebError: Error {
    let description: String
    let code: Int
    
    init(description: String, code: Int = 0) {
        self.description = description
        self.code = code
    }
}

final class APIService {
    typealias Parameters = [String: Any]
    typealias Headers = [String: String]
    
    struct RequestData {
        let url: URL
        let method: HTTPMethod
        let parameters: Parameters?
        let headers: Headers?
        
        init(url: URL, method: HTTPMethod, parameters: Parameters? = nil, headers: Headers? = nil) {
            self.url = url
            self.method = method
            self.parameters = parameters
            self.headers = headers
        }
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    static func requestData(data: RequestData, completion: @escaping Completion<Result<Data, WebError>>) {
        var request = URLRequest(url: data.url)
        request.allHTTPHeaderFields = data.headers
        request.httpMethod = data.method.rawValue
        
        if let parameters = data.parameters {
            let parameterData = parameters.reduce("") { (result, param) -> String in
                return result + "&\(param.key)=\(param.value as! String)"
            }.data(using: .utf8)
            
            request.httpBody = parameterData
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if let error = error {
                completion(.failure(WebError(description: error.localizedDescription, code: statusCode)))
            }
            
            guard let data = data else {
                completion(.failure(WebError(description: "No data provided", code: statusCode)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
