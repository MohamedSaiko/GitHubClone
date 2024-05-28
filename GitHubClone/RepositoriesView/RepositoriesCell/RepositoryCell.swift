//
//  RepositoriyCell.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    
    func configure(fromRepository repository: Repository) {
        repositoryNameLabel.text = repository.name
        
        guard let description = repository.description, let license = repository.license else {
            descriptionLabel.text = "No Description"
            licenseLabel.text = "No License"
            return
        }
        
        descriptionLabel.text = "Description:\n" + description
        licenseLabel.text = "License: \(license.name)"
    }
}
