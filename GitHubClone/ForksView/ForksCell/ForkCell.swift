//
//  ForkCell.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import UIKit

class ForkCell: UITableViewCell {
    @IBOutlet weak var forkName: UILabel!
    
    func configure(fromFork fork: Fork) {
        forkName.text = fork.owner.login
    }
}
