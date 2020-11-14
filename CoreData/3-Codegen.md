# Codegen

When you create an Entity in CoreData (i.e. `Employee`, CoreData looks for two classes to be generated or created. One for the class. Another for the extension.

**Employee+CoreDataClass.swift**

```swift
import Foundation
import CoreData

@objc(Employee)
public class Employee: NSManagedObject {

}
```

**Employee+CoreDataProperties.swift**

```swift
import Foundation
import CoreData

extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}

extension Employee : Identifiable {

}
```

CoreData doesn't care how these classes get generated. It just needs them.

We have three options for generating/creating this classes:

- **Manual/None** - you create both
- **Class Definition** - Xcode creates both
- **Category/Extension** - you create the class, Xcode creates the extension

## Manual/None

With this option you need to generate both these classes yourself. There is a handy [tool](https://developer.apple.com/library/archive/qa/qa1952/_index.html) for doing so.

Choose this option if you want full control for what goes into these classes (i.e. extra properties or parameters). Just be aware you need to keep it in sync your your model yourself.

## Class Definition

With this option Xcode generates all the CoreData classes for you. It keeps them in sync. You never have to worry about updating them. You can't add or modify. Just need to accept and use as they are.

Note: you won't see these directly in your project. They are buried down deep in derived data. Only way to see them is to type out variable name, and click `Show in Finder`.

## Category/Extension

This is the middle of the road option and the one most developers use. With this option Xcode creates the extension class for you (you don't touch that one). But it let's you create the class, so you are free to add extra processing there.



### Links that help

- [Manual/None tool](https://developer.apple.com/library/archive/qa/qa1952/_index.html)
- [Codegen Explained](https://medium.com/@kahseng.lee123/core-data-codegen-explained-462c30341041)

### Video

- [Core Data Codegen Explained](https://www.youtube.com/watch?v=zJmax9KCtd0)

