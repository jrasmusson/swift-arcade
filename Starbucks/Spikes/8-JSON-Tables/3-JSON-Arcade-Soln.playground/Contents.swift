import Foundation

/*
    _ ___  ___  _  _     _                  _
 _ | / __|/ _ \| \| |   /_\  _ _ __ __ _ __| |___
| || \__ \ (_) | .` |  / _ \| '_/ _/ _` / _` / -_)
 \__/|___/\___/|_|\_| /_/ \_\_| \__\__,_\__,_\___|

*/

/*
🕹 Encoder
 
 Given the following JSON payload, create the necessary `struct`s and decode
 the JSON into an array of Swift objects.
 
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
