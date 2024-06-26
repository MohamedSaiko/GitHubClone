//
//  ForkCellViewModel.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 30.05.24.
//

import Foundation

final class ForkCellViewModel {
    private let imageDownloader: AnyImageDownloader
    private let imageCache: NSCache<NSURL, NSData>
    
    init(imageDownloader: AnyImageDownloader, imageCache: NSCache<NSURL, NSData>) {
        self.imageDownloader = imageDownloader
        self.imageCache = imageCache
    }
    
    func downloadImage(fromURL url: URL, completion: @escaping (Data) -> Void) {
        imageDownloader.download(fromURL: url) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let image):
                self.imageCache.setObject(image as NSData, forKey: url as NSURL)
                
                if let cachedImage = self.imageCache.object(forKey: url as NSURL) {
                    self.checkForMainThread {
                        completion(cachedImage as Data)
                    }
                } else {
                    self.checkForMainThread {
                        completion(image)
                    }
                }
                
            case .failure(_):
                if let cachedImage = self.imageCache.object(forKey: url as NSURL) {
                    self.checkForMainThread {
                        completion(cachedImage as Data)
                    }
                }
            }
        }
    }
    
    private func checkForMainThread(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async(execute: completion)
        }
    }
}
