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
    
    private var perPage = 5
    
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
                    DispatchQueue.main.async {
                        completion()
                }
                
            case .failure(let error):
                print(NetworkError.unknownError(error))
            }
        }
    }
}
