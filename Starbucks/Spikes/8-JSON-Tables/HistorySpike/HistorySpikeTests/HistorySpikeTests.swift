//
//  HistorySpikeTests.swift
//  HistorySpikeTests
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-21.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import XCTest

@testable import HistorySpike

class HistorySpikeTests: XCTestCase {

    let json = """
    {
    "transactions": [
      {
        "id": 699519475,
        "type": "redeemed",
        "amount": "150",
        "processed_at": "2020-07-17T12:00:00-00:00"
      },
      {
        "id": 699519475,
        "type": "earned",
        "amount": "10",
        "description": "10 Stars earned",
        "processed_at": "2020-07-17T12:55:27-04:00"
      },
      {
        "id": 699519475,
        "type": "redeemed",
        "amount": "150",
        "processed_at": "2020-06-10T12:56:27-04:00"
      }
     ]
    }
    """
    
    func testJSONParsing() {
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try! decoder.decode(History.self, from: data)

        XCTAssertEqual(3, result.transactions.count)
        
        let first = result.transactions[0]
        XCTAssertEqual(699519475, first.id)
        XCTAssertEqual("redeemed", first.type)
        XCTAssertEqual("150", first.amount)
        XCTAssertNotNil(first.date)
    }
}
