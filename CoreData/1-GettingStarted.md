# Getting Started With CoreData

A simple manager for saving an _Employee_.

```swift
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MyData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
    
    @discardableResult
    func createEmployee(name: String) -> Employee? {
        let context = persistentContainer.viewContext
        
        // old way
        // let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee // NSManagedObject
        
        // new way
        let employee = Employee(context: context)

        employee.name = name

        do {
            try context.save()
            return employee
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchEmployees() -> [Employee]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")

        do {
            let employees = try context.fetch(fetchRequest)
            return employees
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }

    func fetchEmployee(withName name: String) -> Employee? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return nil
    }

    func updateEmployee(employee: Employee) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        context.delete(employee)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }

}
```

Usage like this.

```swift
func DemoCoreData() {
    // Create
    guard let newEmployee = CoreDataManager.shared.createEmployee(name: "Jon") else { return }
    print("Created \(newEmployee)")

    // Read
    guard let employee = CoreDataManager.shared.fetchEmployee(withName: "Jon") else { return }
    guard let employees = CoreDataManager.shared.fetchEmployees() else { return }

    // Update
    CoreDataManager.shared.updateEmployee(employee: employee)
    guard let updatedEmployee = CoreDataManager.shared.fetchEmployee(withName: "Jon") else { return }

    // Delete
    CoreDataManager.shared.deleteEmployee(employee: updatedEmployee)

    print("Number employees: \(employees)")
    print("Number employees: \(employees.count)")
}
```

### Links that help

- [Apple Docs Old](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/index.html
)
- [Apple Docs New](https://developer.apple.com/documentation/coredata)

### Video

- [Getting started with CoreData](https://www.youtube.com/watch?v=PyUyWtpKhFM)

