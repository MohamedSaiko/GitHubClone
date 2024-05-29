//
//  ForksViewCoordinator.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 29.05.24.
//
import UIKit

class ForksViewCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var children = [Coordinator]()
    var navigationController: UINavigationController
    private let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    var repository = ""
    var username = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let forksViewController = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.shared.forksViewController) as? ForksViewController
        
        guard let forksViewController = forksViewController else {
            return
        }
        
        let forksViewModel = ForksViewModel(networkManager: NetworkManager())
        forksViewModel.coordinator = self
        forksViewController.forksViewModel = forksViewModel
        
        forksViewController.repository = repository
        forksViewController.username = username
        
        navigationController.pushViewController(forksViewController, animated: true)
    }
}
