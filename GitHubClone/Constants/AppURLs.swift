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
}
