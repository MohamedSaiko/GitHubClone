//
//  StoryboardIdentifier.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import Foundation

final class StoryboardIdentifier {
    static let shared = StoryboardIdentifier()
    
    let usersViewControllerID = "UsersViewController"
    let repositoriesViewControllerID = "RepositoriesViewController"
    let forksViewController = "ForksViewController"
    
    private init() {}
}
