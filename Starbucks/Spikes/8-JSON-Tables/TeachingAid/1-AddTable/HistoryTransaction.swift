//
//  HistoryTransaction.swift
//  HistorySpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-21.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

/*
 let json = """
 {
 "transactions": [
   {
     "id": 699519475,
     "type": "redeemed",
     "amount": "150",
     "processed_at": "2020-07-17T12:56:27-04:00"
   }
  ]
 }
 """
 */

struct History: Codable {
    let transactions: [Transaction]
}

//struct Transaction: Codable {
//    let id: Int
//    let type: String
//    let amount: String
//    let date: Date
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case type
//        case amount
//        case date = "processed_at"
//    }
//}
