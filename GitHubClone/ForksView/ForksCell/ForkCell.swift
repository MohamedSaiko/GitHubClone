//
//  ForkCell.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import UIKit

final class ForkCell: UITableViewCell {
    private let forkCellViewModel = UserCellViewModel(imageDownloader: ImageDownloader(), imageCache: NSCache<NSURL, NSData>())
    
    @IBOutlet weak var forkName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    private var spinner = UIActivityIndicatorView()
    
    func configure(fromFork fork: Fork) {
        createSpinner(view: userImage)
        
        forkCellViewModel.downloadImage(fromURL: fork.owner.avatarUrl) { [weak self] image in
            guard let self else {
                return
            }
            
            self.userImage.layer.cornerRadius = userImage.frame.width / 2
            self.userImage.layer.borderWidth = 1
            self.userImage.layer.borderColor = UIColor.black.cgColor
            self.userImage.image = UIImage(data: image)
            
            spinner.stopAnimating()
        }
        
        forkName.text = fork.owner.login
    }
    
    private func createSpinner(view: UIView) {
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
    }
}
