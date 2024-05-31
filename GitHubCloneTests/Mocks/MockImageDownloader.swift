//
//  MockImageDownLoader.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 30.05.24.
//

import UIKit
@testable import GitHubClone

final class MockImageDownloader: AnyImageDownloader {
    func download(fromURL url: URL, completion: @escaping (Result<Data, ImageDownloadError>) -> Void) {
        let image = UIImage(named: "GitHubLogoImageBlack")
        guard let data = image?.pngData() else {
            completion(.failure(.downloadingError))
            return
        }
        
        completion(.success(data))
    }
}
