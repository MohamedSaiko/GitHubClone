//
//  RepositoriesViewCoordinator.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 29.05.24.
//

import UIKit

class RepositoriesViewCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var children = [Coordinator]()
    var navigationController: UINavigationController
    private let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    var username = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repositoriesViewController = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.shared.repositoriesViewControllerID) as? RepositoriesViewController
        
        guard let repositoriesViewController = repositoriesViewController else {
            return
        }
        
        let repositoriesViewModel = RepositoriesViewModel(networkManager: NetworkManager())
        repositoriesViewModel.coordinator = self
        repositoriesViewController.repositoriesViewModel = repositoriesViewModel
        repositoriesViewController.username = username
        
        navigationController.pushViewController(repositoriesViewController, animated: true)
    }
    
    func goToForksViewController(withUsername username: String, withRepository repository: String) {
        parentCoordinator?.goToForksViewController(withUsername: username, withRepository: repository)
    }
}
