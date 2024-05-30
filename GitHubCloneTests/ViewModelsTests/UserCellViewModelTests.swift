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
    
    override func setUpWithError() throws {
        let imageDownloader = ImageDownloader()
        userCellViewModel = UserCellViewModel(imageDownloader: imageDownloader, imageCache: NSCache<NSURL, NSData>())
    }
    
    override func tearDownWithError() throws {
        userCellViewModel = nil
        super.tearDown()
    }
    
    func testUserCellViewModelDownloadImage() {
        userCellViewModel.downloadImage(fromURL: URL(fileURLWithPath: "")) { data in
            let image = UIImage(named: "GitHubLogoImage")
            XCTAssertEqual(data, image?.pngData())
        }
    }
}
