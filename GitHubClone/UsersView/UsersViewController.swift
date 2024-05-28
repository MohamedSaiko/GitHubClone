//
//  ViewController.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import UIKit

final class UsersViewController: UIViewController {
    let usersViewModel = UsersViewModel(networkManager: NetworkManager())
    
    @IBOutlet weak private var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.dataSource = self
        
        updateTableView()
    }
    
    func updateTableView() {
        usersViewModel.getUsers { [weak self] in
            guard let self else {
                return
            }
            
            self.usersTableView.reloadData()
        }
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
