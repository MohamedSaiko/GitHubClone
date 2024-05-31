//
//  UserCellViewModelTests.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 30.05.24.
//

import XCTest
@testable import GitHubClone

final class UserCellViewModelTests: XCTestCase {
    var userCellViewModel: UserCellViewModel!
    var imageDownloader: MockImageDownloader!
    var imageCache: MockImageCache!
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        userCellViewModel = nil
        imageDownloader = nil
        imageCache = nil
        super.tearDown()
    }
    
    func testUserCellViewModelDownloadImage() {
        imageDownloader = MockImageDownloader()
        userCellViewModel = UserCellViewModel(imageDownloader: imageDownloader, imageCache: NSCache<NSURL, NSData>())
        
        userCellViewModel.downloadImage(fromURL: URL(fileURLWithPath: "")) { data in
            let image = UIImage(named: "GitHubLogoImageBlack")
            XCTAssertEqual(data, image?.pngData())
        }
    }
    
    func testUserCellViewModelCacheImage() {
        imageCache = MockImageCache()
        userCellViewModel = UserCellViewModel(imageDownloader: imageCache, imageCache: NSCache<NSURL, NSData>())
        
        userCellViewModel.downloadImage(fromURL: URL(fileURLWithPath: "")) { data in
            let image = UIImage(named: "GitHubLogoImageBlack")
            XCTAssertEqual(data, image?.pngData())
        }
    }
}
