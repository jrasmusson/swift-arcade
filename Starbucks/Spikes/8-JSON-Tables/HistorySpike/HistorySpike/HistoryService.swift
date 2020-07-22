//
//  HistoryService.swift
//  HistorySpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-21.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case server
    case parsing
}

struct HistoryService {
    static let shared = HistoryService()
    
    func fetchTransactions(completion: @escaping ((Result<[Transaction], Error>) -> Void)) {

        let url = URL(string: "https://uwyg0quc7d.execute-api.us-west-2.amazonaws.com/prod/history")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            }

            guard let data = data else { return }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(Result.failure(ServiceError.server))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let result = try decoder.decode(History.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(result.transactions)) // update UI
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.failure(ServiceError.parsing))
                }
            }
        }
        task.resume()
    }
}
