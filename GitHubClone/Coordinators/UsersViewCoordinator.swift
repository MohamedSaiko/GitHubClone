//
//  UsersViewCoordinator.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 29.05.24.
//

import UIKit

class UsersViewCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    private let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let usersViewController = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.shared.usersViewControllerID) as? UsersViewController
        
        guard let usersViewController = usersViewController else {
            return
        }
        
        let usersViewModel = UsersViewModel(networkManager: NetworkManager())
        usersViewModel.coordinator = self
        usersViewController.usersViewModel = usersViewModel
        
        navigationController.pushViewController(usersViewController, animated: true)
    }
    
    func goToRepositoriesViewController(withUsername username: String) {
        parentCoordinator?.goToRepositoriesViewController(withUsername: username)
    }
}
