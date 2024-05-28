//
//  Repository.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 28.05.24.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let description: String?
    let license: License?
}

struct Owner: Decodable {
    let login: String
}

struct License: Decodable {
    let name: String
}
