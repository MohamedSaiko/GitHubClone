//
//  ImageDownloader.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import Foundation

protocol AnyImageDownloader {
    func download(fromURL url: URL, completion: @escaping (Result<Data, ImageDownloadError>) -> Void)
}

enum ImageDownloadError: Error {
    case downloadingError
    case noResponse
}

final class ImageDownloader: AnyImageDownloader {
    private let URLSession: URLSession
    
    init(URLSession: URLSession = .shared) {
        self.URLSession = URLSession
    }
    
    func download(fromURL url: URL, completion: @escaping (Result<Data, ImageDownloadError>) -> Void) {
        let task = URLSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.downloadingError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.noResponse))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
