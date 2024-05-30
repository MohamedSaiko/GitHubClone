//
//  NetworkManager.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError
    case decodingError
    case unknownError(Error)
    case noResponse
}

final class NetworkManager {
    private let URLSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(URLSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.URLSession = URLSession
        self.jsonDecoder = decoder
    }
    
    func loadData<T: Decodable>(withURL urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = URL(string: urlString)
        
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.noResponse))
                return
            }
            
            do {
                self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let jsonData = try self.jsonDecoder.decode(T.self, from: data)
                completion(.success(jsonData))
            }
            catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}
