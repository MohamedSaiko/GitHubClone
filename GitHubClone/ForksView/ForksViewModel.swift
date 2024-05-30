//
//  ForksViewModel.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import Foundation

final class ForksViewModel {
    private let networkManager: NetworkManager
    weak var coordinator: ForksViewCoordinator?
    
    private(set) var forks = [Fork]()
    
    private var perPage = 1
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getforks(withUsername name: String, withRepository repository: String, completion: @escaping () -> Void) {
        let url = AppURLs.shared.createForksURL(fromusername: name, FromRepository: repository) + AppURLs.shared.paginate(perPage: perPage)
        
        networkManager.loadData(withURL: url) { [weak self] (result: Result<[Fork], NetworkError>) in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let forkData):
                self.forks.append(contentsOf: forkData)
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
    
    func checkForMainThread(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async(execute: completion)
        }
    }
}
