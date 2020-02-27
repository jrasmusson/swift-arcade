import UIKit
import Foundation
import Combine

class Wizard {
    var grade: Int
    init(grade: Int) {
        self.grade = grade
    }
}

let merlin = Wizard(grade: 5)

// Define notification
extension Notification.Name {
    static let graduated = Notification.Name("Graduated")
}

// Create publisher that converts `Output` into `Int` which we can then assign to a KVO enabled model and grade property
let cancellable =
    NotificationCenter.default.publisher(for: .graduated, object: merlin)
        .map { note in
            return note.userInfo?["NewGrade"] as? Int ?? 0
    }
        .assign(to: \.grade, on: merlin)

// Post
let userInfo:[String: Int] = ["NewGrade": 12]
NotificationCenter.default.post(name: .graduated, object: nil, userInfo: userInfo)

merlin.grade

print(merlin.grade)

// Why not working?
