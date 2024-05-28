//
//  RepositoriesViewController.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import UIKit

class RepositoriesViewController: UIViewController {
    private let repositoriesViewModel = RepositoriesViewModel(networkManager: NetworkManager())
    var username = ""
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "\(username)'s Repositories"
        repositoriesTableView.dataSource = self
        
        repositoriesViewModel.getRepositories(withUsername: username) { [weak self] in
            guard let self else {
                return
            }
            
            repositoriesTableView.reloadData()
        }
    }
}

//MARK: RepositoriesTableViewDataSource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesViewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repositoryCell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifier.shared.repositoryCellID, for: indexPath) as? RepositoryCell
        
        guard let repositoryCell = repositoryCell else {
            return UITableViewCell()
        }
        
        repositoryCell.configure(fromRepository: repositoriesViewModel.repositories[indexPath.row])
        return repositoryCell
    }
}
