## Functions as variables

Functions can be instantiated and passed around like any other variable. This can be handy in testing (no need to mock an object in it's entirety) or flexible API that take a _func_ instead of classes, structs, and enums.

Here for example we define a _Math_ struct with a func called _addTwoInts_. Think of this func definition just like any other Swift _var_ or _let_. 

```swift
import UIKit

struct Math {

    // think of this as a variable
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    // just like any other var or let
    var name = "Math 101"
}
```

We can then define it as a variable type in a class. And change it's value.

```swift
struct Calculator {
    var mathFunction: (Int, Int) -> Int = Math().addTwoInts
}

var calc = Calculator()
calc.mathFunction = Math().subTwoInts
```

Or we can use it as an argument and pass it to other functions.

```swift
struct Command {

    func execute(twoIntEquation: (Int, Int) -> Int) {
        let answer = twoIntEquation(1, 2)
        print("\(answer)")
    }
}

let command = Command()
command.execute(twoIntEquation: Math().addTwoInts(_:_:))
```

If your func expression is complicated use a `typealias`.

```swift
struct Calculator {
    typealias expression = (Int, Int) -> Int
    var mathFunction: expression = Math().addTwoInts
}
```

## An Example

Here is a unit test that passes in a _UserManager_ _delete_ func as a variable in a _UIViewController_.

```swift
class UserManager {
}

extension UserManager {
    func deleteUser(id: Int) {}
}

class ViewController: UIViewController {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var userManager: UserManager

    // Create an optional var of the func you want to override.
    var deleteFunc: ((Int) -> ())?

    init(userManager: UserManager) {
        self.userManager = userManager
        super.init(nibName: nil, bundle: nil)
    }


    func deleteButtonPressed() {
        let myDeleteFunc = deleteFunc ?? userManager.deleteUser(id:)
        myDeleteFunc(1)
    }

}

class UnitTest {
    
    func myMockDeleteFunc(id: Int) {
        print("fake delete")
    }
    
    func testDelete() {
        let userManager = UserManager()
        let viewController = ViewController(userManager: userManager)
        
        viewController.deleteFunc = myMockDeleteFunc(id:)
        
        viewController.deleteButtonPressed()
    }
    
}
```

The manager couldn't be easily override because you can't override non@objc methods defined in extensions. So passing in a func instead here really helped. 


### Video

- [Swift Arcade Video](https://www.youtube.com/watch?v=XAnICKPjoTU)