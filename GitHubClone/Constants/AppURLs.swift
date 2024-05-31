//
//  UsersUrl.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import Foundation

final class AppURLs {
    static let shared = AppURLs()
    let usersURL = "https://api.github.com/users"
    
    private init() {}
    
    func paginate(perPage: Int) -> String {
        "?per_page=\(perPage)"
    }
    
    func formatURL(withUsername username: String) -> String {
        "/\(username)/repos"
    }
    
    func createForksURL(fromusername name: String, FromRepository repository: String) -> String {
        return "https://api.github.com/repos/\(name)/\(repository)/forks"
    }
}
