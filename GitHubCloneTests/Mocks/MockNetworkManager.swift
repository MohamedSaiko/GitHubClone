//
//  NetworkManagerMock.swift
//  GitHubCloneTests
//
//  Created by Mohamed Sayed on 30.05.24.
//

import Foundation
@testable import GitHubClone

class MockNetworkManager: AnyNetworkManager {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadData<T: Decodable>(withURL urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let path = bundle.url(forResource: urlString, withExtension: "json") else {
            fatalError("Failed to load json.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let jsonData = try jsonDecoder.decode(T.self, from: data)
            
            completion(.success(jsonData))
        }
        catch {
            completion(.failure(NetworkError.decodingError))
            fatalError("Failed to load json.")
        }
    }
}
