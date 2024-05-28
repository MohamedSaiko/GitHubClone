//
//  UserCell.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import UIKit

final class UserCell: UITableViewCell {
    private let userCellViewModel = UserCellViewModel(imageDownloader: ImageDownloader())
    
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var usernameLabel: UILabel!
    @IBOutlet weak private var repositoriesLabel: UILabel!
    @IBOutlet weak private var followersLabel: UILabel!
    private var spinner = UIActivityIndicatorView()
    
    func configure(fromUser user: User) {
        createSpinner(view: userImage)
        
        userCellViewModel.downloadImage(fromURL: user.avatarUrl) { [weak self] image in
            guard let self else {
                return
            }
            
            self.userImage.layer.cornerRadius = userImage.frame.width / 2
            self.userImage.layer.borderWidth = 1
            self.userImage.layer.borderColor = UIColor.black.cgColor
            self.userImage.image = UIImage(data: image)
            
            spinner.stopAnimating()
        }
        
        usernameLabel.text = user.login
        repositoriesLabel.text = "Repositories: \(user.publicRepos)"
        followersLabel.text = "Followers: \(user.followers)"
    }
    
    private func createSpinner(view: UIView) {
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
    }
}
