//
//  CellIdentifier.swift
//  GitHubClone
//
//  Created by Mohamed Sayed on 27.05.24.
//

import Foundation

final class CellsIdentifier {
    static let shared = CellsIdentifier()
    let userCellID = "UserCell"
    let repositoryCellID = "RepositoryCell"
    
    private init() {}
}
