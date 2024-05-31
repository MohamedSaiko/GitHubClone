//
//  MainCoordinator.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 29.05.24.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

final class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        goToUsersViewController()
    }
    
    private func goToUsersViewController() {
        let child = UsersViewCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        children.append(child)
        child.start()
    }
    
    func goToRepositoriesViewController(withUsername username: String) {
        let child = RepositoriesViewCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        children.append(child)
        child.username = username
        child.start()
    }
    
    func goToForksViewController(withUsername username: String, withRepository repository: String) {
        let child = ForksViewCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        children.append(child)
        child.repository = repository
        child.username = username
        child.start()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a users view controller
        if let usersViewController = fromViewController as? UsersViewController {
            // We're popping a users view controller; end its coordinator
            childDidFinish(usersViewController.usersViewModel?.coordinator)
        }
        
        if let repositoriesViewController = fromViewController as? RepositoriesViewController {
            // We're popping a repositories view controller; end its coordinator
            childDidFinish(repositoriesViewController.repositoriesViewModel?.coordinator)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated() {
            if coordinator === child {
                children.remove(at: index)
                break
            }
        }
    }
}
