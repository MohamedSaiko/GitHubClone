//
//  RepositoriesViewModelTests.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 30.05.24.
//

import XCTest
@testable import GitHubClone

final class UsersViewModelTests: XCTestCase {
    var usersViewModel: UsersViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        usersViewModel = UsersViewModel(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        usersViewModel = nil
        super.tearDown()
    }
    
    func testUsersViewModelGetUsers() {
        mockNetworkManager.loadData(withURL: "Users") { (result: Result<[UserData], NetworkError>) in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 3)
                XCTAssertEqual(users[0].url, "https://api.github.com/users/mojombo")
                XCTAssertEqual(users[1].url, "https://api.github.com/users/defunkt")
                XCTAssertEqual(users[2].url, "https://api.github.com/users/pjhyett")
                
            case .failure(_):
                XCTFail()
            }
        }
    }
}
