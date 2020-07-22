import Foundation

/*
    _ ___  ___  _  _
 _ | / __|/ _ \| \| |
| || \__ \ (_) | .` |
 \__/|___/\___/|_|\_|

*/

let json = """
{
"transactions": [
  {
    "id": 699519475,
    "type": "redeemed",
    "amount": "150",
    "processed_at": "2020-07-17T12:56:27-04:00"
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
  },
  {
    "id": 699519475,
    "type": "earned",
    "amount": "10",
    "processed_at": "2020-05-24T12:56:27-04:00"
  },
  {
    "id": 699519475,
    "type": "earned",
    "amount": "10",
    "description": "10 Stars earned",
    "processed_at": "2020-05-11T12:56:27-04:00"
  },
  {
    "id": 699519475,
    "type": "earned",
    "amount": "10",
    "processed_at": "2020-05-11T12:56:27-04:00"
  }
 ]
}
"""

struct History: Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let id: Int
    let type: String
    let amount: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case date = "processed_at"
    }
}

let data = json.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let result = try! decoder.decode(History.self, from: data)

result.transactions[0].id
result.transactions[0].type
result.transactions[0].amount
result.transactions[0].date

let json2 = """
[
  {
    "id": 699519475,
    "type": "redeemed",
    "amount": "150",
    "processed_at": "2020-07-17T12:56:27-04:00"
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
"""

let data2 = json2.data(using: .utf8)!
let decoder2 = JSONDecoder()
decoder2.dateDecodingStrategy = .iso8601
let result2 = try! decoder2.decode([Transaction].self, from: data2)

result2[0].id
result2[0].type
result2[0].amount
result2[0].date
