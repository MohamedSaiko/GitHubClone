//
//  MockImageCache.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 31.05.24.
//

import UIKit
@testable import GitHubClone

final class MockImageCache: AnyImageDownloader {
    func download(fromURL url: URL, completion: @escaping (Result<Data, ImageDownloadError>) -> Void) {
        let imageName = "GitHubLogoImageBlack"
        let image = UIImage(named: imageName)
        
        guard let data = image?.pngData() else {
            completion(.failure(.downloadingError))
            return
        }
        
        let imageCache = NSCache<NSString, NSData>()
        imageCache.setObject(data as NSData, forKey: imageName as NSString)
        
        if let cachedImage = imageCache.object(forKey: imageName as NSString) {
            completion(.success(cachedImage as Data))
        } else {
            completion(.failure(.downloadingError))
        }
    }
}
