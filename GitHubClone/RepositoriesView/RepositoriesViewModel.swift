//
//  RepositoriesViewModel.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import Foundation

final class RepositoriesViewModel {
    private let networkManager: AnyNetworkManager
    weak var coordinator: RepositoriesViewCoordinator?
    
    private(set) var repositories = [Repository]()
    
    private var perPage = 1
    
    init(networkManager: AnyNetworkManager) {
        self.networkManager = networkManager
    }
    
    func getRepositories(withUsername username: String, completion: @escaping () -> Void) {
        let url = AppURLs.shared.usersURL + AppURLs.shared.formatURL(withUsername: username) + AppURLs.shared.paginate(perPage: perPage)
        
        networkManager.loadData(withURL: url) { [weak self] (result: Result<[Repository], NetworkError>) in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let repositoryData):
                self.repositories.append(contentsOf: repositoryData)
                self.checkForMainThread {
                    completion()
                }
                
            case .failure(let error):
                self.checkForMainThread {
                    self.coordinator?.showAlert(withTitle: "Error!", withMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func goToForksViewController(withIndex index: Int) {
        let username = repositories[index].owner.login
        let repository = repositories[index].name
        
        coordinator?.goToForksViewController(withUsername: username, withRepository: repository)
    }
    
    func checkForMainThread(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async(execute: completion)
        }
    }
}
