//
//  ForkCellViewModelTests.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 30.05.24.
//

import XCTest
@testable import GitHubClone

final class ForkCellViewModelTests: XCTestCase {
    var forkCellViewModel: ForkCellViewModel!
    var imageDownloader: MockImageDownloader!
    var imageCache: MockImageCache!
    
    override func tearDownWithError() throws {
        forkCellViewModel = nil
        imageDownloader = nil
        imageCache = nil
        super.tearDown()
    }
    
    func testUserCellViewModelDownloadImage() {
        let imageDownloader = MockImageDownloader()
        forkCellViewModel = ForkCellViewModel(imageDownloader: imageDownloader, imageCache: NSCache<NSURL, NSData>())
        
        forkCellViewModel.downloadImage(fromURL: URL(fileURLWithPath: "")) { data in
            let image = UIImage(named: "GitHubLogoImageBlack")
            XCTAssertEqual(data, image?.pngData())
        }
    }
    
    func testUserCellViewModelCacheImage() {
        imageCache = MockImageCache()
        forkCellViewModel = ForkCellViewModel(imageDownloader: imageCache, imageCache: NSCache<NSURL, NSData>())
        
        forkCellViewModel.downloadImage(fromURL: URL(fileURLWithPath: "")) { data in
            let image = UIImage(named: "GitHubLogoImageBlack")
            XCTAssertEqual(data, image?.pngData())
        }
    }
}
