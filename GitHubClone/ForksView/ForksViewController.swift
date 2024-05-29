//
//  ForksViewController.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import UIKit

class ForksViewController: UIViewController {
    var forksViewModel: ForksViewModel?
    var repository = ""
    var username = ""
    
    @IBOutlet private weak var forksTableView: UITableView!
    private var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forksTableView.dataSource = self
        
        createSpinner()
        updateTableView()
    }
    
    private func updateTableView() {
        forksViewModel?.getforks(withUsername: username, withRepository: repository) { [weak self] in
            guard let self else {
                return
            }
            
            spinner.stopAnimating()
            self.forksTableView.reloadData()
        }
    }
    
    private func createSpinner() {
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
    }
}

//MARK: ForksTableViewDataSource

extension ForksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forksViewModel?.forks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forkCell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifier.shared.forkCellID, for: indexPath) as? ForkCell
        
        guard let forkCell = forkCell, let forksViewModel = forksViewModel else {
            return UITableViewCell()
        }
        
        forkCell.configure(fromFork: forksViewModel.forks[indexPath.row])
        return forkCell
    }
}
