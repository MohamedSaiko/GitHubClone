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
    
    @IBOutlet private weak var repositoriesTableView: UITableView!
    private var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "\(username)'s Repositories"
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        
        createSpinner()
        updateTableView()
    }
    
    private func updateTableView() {
        repositoriesViewModel.getRepositories(withUsername: username) { [weak self] in
            guard let self else {
                return
            }
            
            spinner.stopAnimating()
            repositoriesTableView.reloadData()
        }
    }
    
    private func createSpinner() {
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
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

//MARK: RepositoriesTableViewDelegate

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let forksViewController = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.shared.forksViewController) as? ForksViewController
        
        guard let forksViewController = forksViewController else {
            return
        }
        
        forksViewController.username = repositoriesViewModel.repositories[indexPath.row].owner.login
        forksViewController.repository = repositoriesViewModel.repositories[indexPath.row].name
        
        navigationController?.pushViewController(forksViewController, animated: true)
    }
}
