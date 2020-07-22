/*
     _ ___  ___  _  _
  _ | / __|/ _ \| \| |
 | || \__ \ (_) | .` |
  \__/|___/\___/|_|\_|

 */

import Foundation

let json = """
 {
    "type": "US Robotics",
    "model": "Sportster"
 }
"""

// JSON > Swift (struct or class)

struct Modem: Codable {
    let type: String
    let model: String
}

let jsonData = json.data(using: .utf8)!
let result = try! JSONDecoder().decode(Modem.self, from: jsonData)

result
result.type
result.model

// Swift > JSON

var modem = Modem(type: "Hayes", model: "5611")

let jsonData2 = try! JSONEncoder().encode(modem)
let json2 = String(data: jsonData2, encoding: .utf8)!
json2

// What if Swift properties differ from from JSON? CodingKeys

let jsonUser = """
{
    "first_name": "John",
    "last_name": "Doe",
    "country": "United Kingdom"
}
"""

struct User:Codable
{
    var firstName:String
    var lastName:String
    var country:String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case country
    }
}

let jsonUserData = jsonUser.data(using: .utf8)!
let userResult = try! JSONDecoder().decode(User.self, from: jsonUserData)
userResult.firstName

// Other Codable data types include
// - URL, Number, Bool, Array, Dictionary Date, Null, other JSON objects

let jsonOtherTypes = """
 {
     "name": "The Witcher",
     "seasons": 1,
     "rate": 9.3,
     "favorite": null,
     "genres":["Animation", "Comedy", "Drama"],
     "countries":{"Canada":"CA", "United States":"USA"},
     "platform": {
         "name": "Netflix",
         "ceo": "Reed Hastings"
     },
    "url":"https://en.wikipedia.org/wiki/BoJack_Horseman"
 }
"""

struct Show: Decodable {
    let name: String
    let seasons: Int
    let rate: Float
    let favorite: Bool?
    let genres: [String]
    let countries: Dictionary<String, String>
    let platform: Platform
    let url: URL
    
    struct Platform: Decodable {
        let name: String
        let ceo: String
    }
}

let jsonOtherData = jsonOtherTypes.data(using: .utf8)!
let showResult = try! JSONDecoder().decode(Show.self, from: jsonOtherData)
print(showResult)

// Dates

// If milliseconds - nothing to do.

let jsonMs = """
{
  "date" : 519751611.12542897
}
"""

struct DateRecord : Codable {
    let date: Date
}

let msData = jsonMs.data(using: .utf8)!
let msResult = try! JSONDecoder().decode(DateRecord.self, from: msData)
msResult.date

// If iso8601 use dateEncodingStrategy.

let jsonIso = """
{
  "date" : "2017-06-21T15:29:32Z"
}
"""

let isoData = jsonIso.data(using: .utf8)!
let isoDecoder = JSONDecoder()
isoDecoder.dateDecodingStrategy = .iso8601
let isoResult = try! isoDecoder.decode(DateRecord.self, from: isoData)
isoResult.date

// If non-standard use `DateFormatter`.

let jsonNS = """
{
  "date" : "2020-03-19"
}
"""

// Define custom DateFormatter
extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

let nsData = jsonNS.data(using: .utf8)!
let nsDecoder = JSONDecoder()
nsDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
let nsResult = try! nsDecoder.decode(DateRecord.self, from: nsData)
nsResult.date


// Dictionary with Array

let jsonDict = """
{
"employees": [
  {
    "firstName": "Kevin",
    "lastName": "Flynn",
  },
  {
    "firstName": "Allan",
    "lastName": "Bradley",
  },
  {
    "firstName": "Ed",
    "lastName": "Dillinger",
  }
 ]
}
"""

struct Company: Codable {
    let employees: [Employee]
}

struct Employee: Codable {
    let firstName: String
    let lastName: String
}

let dictData = jsonDict.data(using: .utf8)!
let dictDecoder = JSONDecoder()
let dictResult = try! dictDecoder.decode(Company.self, from: dictData)

dictResult.employees[0].firstName
dictResult.employees[0].lastName

// Array only

let jsonArray = """
[
  {
    "firstName": "Kevin",
    "lastName": "Flynn",
  },
  {
    "firstName": "Allan",
    "lastName": "Bradley",
  },
  {
    "firstName": "Ed",
    "lastName": "Dillinger",
  }
]
"""

let arrayData = jsonArray.data(using: .utf8)!
let arrayDecoder = JSONDecoder()
let arrayResult = try! arrayDecoder.decode([Employee].self, from: arrayData)

arrayResult[0].firstName
arrayResult[0].lastName
