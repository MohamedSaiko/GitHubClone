//
//  UserCell.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import UIKit

final class UserCell: UITableViewCell {
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var usernameLabel: UILabel!
    @IBOutlet weak private var repositoriesLabel: UILabel!
    @IBOutlet weak private var followersLabel: UILabel!
    
    func configure(fromUser user: User) {
//        userImage.layer.cornerRadius = userImage.frame.width / 2
//        userImage.layer.borderWidth = 1
//        userImage.layer.borderColor = UIColor.black.cgColor
 //       userImage.image = U
        
        usernameLabel.text = user.login
        repositoriesLabel.text = "Repositories: \(user.publicRepos)"
        followersLabel.text = "Followers: \(user.followers)"
    }
}
