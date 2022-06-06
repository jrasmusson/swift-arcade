//
//  HomeViewController+Networking.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-06-06.
//

import Foundation

protocol HomeManageable: AnyObject {
    func fetchItems(forUserId userId: String, completion: @escaping (Result<[HomeItem],NetworkError>) -> Void)
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

class HomeManager: HomeManageable {
    func fetchItems(forUserId userId: String, completion: @escaping (Result<[HomeItem],NetworkError>) -> Void) {
        var isLocal = false
        if ProcessInfo.processInfo.environment["isLocal"] == "YES" {
            isLocal = true
        }

        if isLocal {
            self.fetchLocalItems(forUserId: userId, completion: completion)
        } else {
            self.fetchNetworkItems(forUserId: userId, completion: completion)
        }
    }

    func fetchLocalItems(forUserId userId: String, completion: @escaping (Result<[HomeItem],NetworkError>) -> Void) {
        let result: [HomeItem] = loadData("homeItemData.json")
        completion(.success(result))
    }

    func fetchNetworkItems(forUserId userId: String, completion: @escaping (Result<[HomeItem],NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/kijiji/homeitems/\(userId)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }

                do {
                    let result = try JSONDecoder().decode([HomeItem].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
