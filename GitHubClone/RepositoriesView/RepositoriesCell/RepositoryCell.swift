//
//  RepositoriyCell.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var licenseLabel: UILabel!
    
    func configure(fromRepository repository: Repository) {
        repositoryNameLabel.text = repository.name
        
        guard let description = repository.description, let license = repository.license else {
            descriptionLabel.text = "No Description"
            licenseLabel.text = "No License"
            return
        }
        
        descriptionLabel.text = description
        licenseLabel.text = "License: \(license.name)"
    }
}
