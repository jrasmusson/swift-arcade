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
    "description": "150 Stars redeemed",
    "processed_at": "2020-07-10T12:56:27-04:00"
  }
 ]
}
"""

struct History : Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let id: Int
    let description: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case description
        case id
        case date = "processed_at"
    }
}

let data = json.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let result = try! decoder.decode(History.self, from: data)

result.transactions[0].id
result.transactions[0].description
result.transactions[0].date

// https://shopify.dev/docs/admin-api/rest/reference/shopify_payments/transaction?api



