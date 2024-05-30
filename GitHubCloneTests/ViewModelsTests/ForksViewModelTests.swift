//
//  ForksViewModelTests.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 30.05.24.
//

import XCTest
@testable import GitHubClone

final class ForksViewModelTests: XCTestCase {
    var forksViewModel: ForksViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        forksViewModel = ForksViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        forksViewModel = nil
        super.tearDown()
    }
    
    func testForksViewModelGetForks() {
        mockNetworkManager.loadData(withURL: "Forks") { (result: Result<[Fork], NetworkError>) in
            switch result {
            case .success(let forks):
                XCTAssertEqual(forks.count, 3)
                XCTAssertEqual(forks[0].owner.login, "guoyu07")
                XCTAssertEqual(forks[1].owner.login, "RihabAzzabi")
                XCTAssertEqual(forks[2].owner.login, "cha63506")
                
            case .failure(_):
                XCTFail()
            }
        }
    }
}
