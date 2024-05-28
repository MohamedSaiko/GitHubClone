//
//  UserCellViewModel.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import Foundation

final class UserCellViewModel {
    private let imageDownloader: ImageDownloader
    
    init(imageDownloader: ImageDownloader) {
        self.imageDownloader = imageDownloader
    }
    
    func downloadImage(fromURL url: URL, completion: @escaping (Data) -> Void) {
        imageDownloader.download(fromURL: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
