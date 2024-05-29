//
//  ViewController.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import UIKit

final class UsersViewController: UIViewController {
    var usersViewModel: UsersViewModel?
    
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
        usersViewModel?.getUsers { [weak self] in
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
        return usersViewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifier.shared.userCellID, for: indexPath) as? UserCell
        
        guard let userCell = userCell, let usersViewModel = usersViewModel else {
            return UITableViewCell()
        }
        
        userCell.configure(fromUser: usersViewModel.users[indexPath.row])
        return userCell
    }
}

//MARK: UsersTableViewDelegate

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usersViewModel?.goToRepositoriesViewController(withIndex: indexPath.row)
    }
}
