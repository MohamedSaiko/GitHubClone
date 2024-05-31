//
//  UsersViewModel.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import Foundation

final class UsersViewModel {
    private let networkManager: AnyNetworkManager
    weak var coordinator: UsersViewCoordinator?
    
    private(set) var usersData = [UserData]()
    private(set) var users = [String : User]()
    
    private var perPage = 20
    
    init(networkManager: AnyNetworkManager) {
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
                    if userData.count == self.users.count {
                        self.checkForMainThread {
                            completion()
                        }
                    }
                }
                
            case .failure(let error):
                self.checkForMainThread {
                    self.coordinator?.showAlert(withTitle: "Error!", withMessage: error.localizedDescription)
                }
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
                    users[user.login] = user
                    completion()
                    
                case .failure(let error):
                    self.checkForMainThread {
                        self.coordinator?.showAlert(withTitle: "Error!", withMessage: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func goToRepositoriesViewController(withIndex index: Int) {
        let login = usersData[index].login
        
        guard let user = users[login] else {
            return
        }
        
        let username = user.login
        coordinator?.goToRepositoriesViewController(withUsername: username)
    }
    
    func checkForMainThread(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async(execute: completion)
        }
    }
}
