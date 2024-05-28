//
//  ViewController.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import UIKit

final class UsersViewController: UIViewController {
    private let usersViewModel = UsersViewModel(networkManager: NetworkManager())
    
    @IBOutlet weak private var usersTableView: UITableView!
    private var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
        createSpinner()
        updateTableView()
    }
    
    private func updateTableView() {
        usersViewModel.getUsers { [weak self] in
            guard let self else {
                return
            }
            
            spinner.stopAnimating()
            self.usersTableView.reloadData()
        }
    }
    
    private func createSpinner() {
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
    }
}

//MARK: UsersTableViewDataSource

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifier.shared.userCellID, for: indexPath) as? UserCell
        
        guard let userCell = userCell else {
            return UITableViewCell()
        }
        
        userCell.configure(fromUser: usersViewModel.users[indexPath.row])
        return userCell
    }
}

//MARK: UsersTableViewDelegate

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoriesViewController = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.shared.repositoriesViewControllerID) as? RepositoriesViewController
        
        guard let repositoriesViewController = repositoriesViewController else {
            return
        }
        
        repositoriesViewController.username = usersViewModel.users[indexPath.row].login
        navigationController?.pushViewController(repositoriesViewController, animated: true)
    }
}
