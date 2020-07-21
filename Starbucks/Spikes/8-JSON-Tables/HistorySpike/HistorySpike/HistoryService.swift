//
//  HistoryService.swift
//  HistorySpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-21.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case network
    case server
    case parsing
}

struct HistoryService {
    static let shared = HistoryService()
    
    func fetchTransactions(completion: @escaping ((Result<[Transaction], Error>) -> Void)) {

//        let url = URL(string: "https://uwyg0quc7d.execute-api.us-west-2.amazonaws.com/prod/account")!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse,
//                (200...299).contains(httpResponse.statusCode) else {
//                print("Server Error")
//                return
//            }
//            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
//                let data = data,
//                let string = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
//                    // update UI
//                    print(string)
//                }
//            }
//        }
//        task.resume()
        
        // Success
        completion(Result.success(createTestData()))

       // Error
//       completion(Result.failure(ServiceError.parsing))
    }
    
    func createTestData() -> [Transaction]{
        let tx1 = Transaction(id: 1, type: "redeemed", amount: "1", date: Date())
        let tx11 = Transaction(id: 1, type: "redeemed", amount: "11", date: Date())

        let tx2 = Transaction(id: 1, type: "redeemed", amount: "2", date: Date())

        let tx3 = Transaction(id: 1, type: "redeemed", amount: "3", date: Date())
        let tx33 = Transaction(id: 1, type: "redeemed", amount: "33", date: Date())
        let tx333 = Transaction(id: 1, type: "redeemed", amount: "333", date: Date())

        return [tx1, tx11, tx2, tx3, tx33, tx333]
//        let section1 = HistorySection(title: "July", transactions: [tx1, tx11])
//        let section2 = HistorySection(title: "June", transactions: [tx2])
//        let section3 = HistorySection(title: "May", transactions: [tx3, tx33, tx333])
//
//        viewModel = HistoryViewModel(sections: [section1, section2, section3])
    }

}
