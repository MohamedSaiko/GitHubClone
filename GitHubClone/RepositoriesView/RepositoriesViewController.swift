//
//  RepositoriesViewController.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import UIKit

final class RepositoriesViewController: UIViewController {
    var repositoriesViewModel: RepositoriesViewModel?
    var username = ""
    
    @IBOutlet private weak var repositoriesTableView: UITableView!
    private var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(username)'s Repositories"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        
        createSpinner()
        updateTableView()
    }
    
    private func updateTableView() {
        repositoriesViewModel?.getRepositories(withUsername: username) { [weak self] in
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
        return repositoriesViewModel?.repositories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repositoryCell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifier.shared.repositoryCellID, for: indexPath) as? RepositoryCell
        
        guard let repositoryCell = repositoryCell, let repositoriesViewModel = repositoriesViewModel else {
            return UITableViewCell()
        }
        
        repositoryCell.configure(fromRepository: repositoriesViewModel.repositories[indexPath.row])
        return repositoryCell
    }
}

//MARK: RepositoriesTableViewDelegate

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repositoriesViewModel?.goToForksViewController(withIndex: indexPath.row)
    }
}
