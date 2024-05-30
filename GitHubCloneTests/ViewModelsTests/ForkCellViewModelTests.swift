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
    
    override func setUpWithError() throws {
        let imageDownloader = ImageDownloader()
        forkCellViewModel = ForkCellViewModel(imageDownloader: imageDownloader, imageCache: NSCache<NSURL, NSData>())
    }
    
    override func tearDownWithError() throws {
        forkCellViewModel = nil
        super.tearDown()
    }
    
    func testUserCellViewModelDownloadImage() {
        forkCellViewModel.downloadImage(fromURL: URL(fileURLWithPath: "")) { data in
            let image = UIImage(named: "GitHubLogoImage")
            XCTAssertEqual(data, image?.pngData())
        }
    }
}
