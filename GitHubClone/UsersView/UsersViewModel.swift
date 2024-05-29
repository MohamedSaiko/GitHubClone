//
//  UsersViewModel.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import Foundation

final class UsersViewModel {
    private let networkManager: NetworkManager
    
    private(set) var usersData = [UserData]()
    private(set) var users = [User]()
    
    private var perPage = 1
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getUsers(completion: @escaping () -> Void) {
        let url = AppURLs.shared.usersURL + AppURLs.shared.paginate(perPage: perPage)
        
        networkManager.loadData(withURL: url) { [weak self] (result: Result<[UserData], NetworkError>) in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let userData):
                self.usersData.append(contentsOf: userData)
                self.getSingleUser {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
                
            case .failure(let error):
                print(NetworkError.unknownError(error))
            }
        }
    }
    
    func getSingleUser(completion: @escaping () -> Void) {
        guard !usersData.isEmpty else {
            return
        }
        
        for user in usersData {
            networkManager.loadData(withURL: user.url) { [weak self] (result: Result<User, NetworkError>) in
                guard let self else {
                    return
                }
                
                switch result {
                case .success(let user):
                    users.append(user)
                    users.sort {
                        $0.id < $1.id
                    }
                    
                    completion()
                    
                case .failure(let error):
                    print(NetworkError.unknownError(error))
                }
            }
        }
    }
}
