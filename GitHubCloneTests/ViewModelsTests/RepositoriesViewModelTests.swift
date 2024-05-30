//
//  RepositoriesViewModelTests.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 30.05.24.
//

import XCTest
@testable import GitHubClone

final class RepositoriesViewModelTests: XCTestCase {
    var repositoriesViewModel: RepositoriesViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        repositoriesViewModel = RepositoriesViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        repositoriesViewModel = nil
        super.tearDown()
    }
    
    func testRepositoriesViewModelGetRepositories() {
        mockNetworkManager.loadData(withURL: "Repositories") { (result: Result<[Repository], NetworkError>) in
            switch result {
            case .success(let repositories):
                XCTAssertEqual(repositories.count, 3)
                XCTAssertEqual(repositories[0].name, "30daysoflaptops.github.io")
                XCTAssertEqual(repositories[1].license?.name, "Other")
                XCTAssertEqual(repositories[2].description, "The personal website of Ben Balter. Built using Jekyll and GitHub Pages. See humans.txt for more infos.")
                
            case .failure(_):
                XCTFail()
            }
        }
    }
}
