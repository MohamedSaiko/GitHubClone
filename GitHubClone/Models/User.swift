//
//  User.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import Foundation

struct User: Decodable {
    let id: Int
    let login: String
    let avatarUrl: URL
    let publicRepos: Int
    let followers: Int
    let url: String
}
