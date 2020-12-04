//
//  EmployeeDataManager.swift
//  CoreDataUnitTest
//
//  Created by jrasmusson on 2020-11-15.
//

import UIKit
import CoreData

/*
 This more complex implementation does everything on the background thread.
 More performant. But also more complex and risky.
 */
class ComplexEmployeeManager {
 
    // MARK: Contexts
    
    let backgroundcontext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    /*
     Note: All fetches should always be done on mainContext. Updates, creates, deletes can be background.
     Contexts are passed in so they can be overridden via unit testing.
     */
    
    // MARK: - Init
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext,
         backgroundContext: NSManagedObjectContext = CoreDataStack.shared.backgroundContext) {
        self.mainContext = mainContext
        self.backgroundcontext = backgroundContext
    }
    
    // MARK: - Create
    
    func createEmployee(firstName: String) {
        backgroundcontext.performAndWait {
            let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: backgroundcontext) as! Employee
            employee.firstName = firstName
            
            try? backgroundcontext.save()
        }
    }
    
    // MARK: - Deletion
    
    func deleteEmployee(employee: Employee) {
        let objectID = employee.objectID
        backgroundcontext.performAndWait {
            if let employeeInContext = try? backgroundcontext.existingObject(with: objectID) {
                backgroundcontext.delete(employeeInContext)
                try? backgroundcontext.save()
            }
        }
    }
        
    // MARK: - Update
    
    func updateEmployee(employee: Employee) {
        backgroundcontext.performAndWait {
            do {
                try backgroundcontext.save()
            } catch let error {
                print("Failed to update: \(error)")
            }
        }
    }
    
    // MARK: - Fetch
    
    /*
     Rule: Managed objects retrieved from a context are bound to the same queue that the context is bound to.
     
     So if we want the results of our fetches to be used in the UI, we should do those fetching
     from the main UI context.
     
     */
    func fetchEmployee(withName name: String) -> Employee? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "firstName == %@", name)
        
        var employee: Employee?
        
        mainContext.performAndWait {
            do {
                let employees = try mainContext.fetch(fetchRequest)
                employee = employees.first
            } catch let error {
                print("Failed to fetch: \(error)")
            }
        }
        
        return employee
    }

    func fetchEmployees() -> [Employee]? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        var employees: [Employee]?
        
        mainContext.performAndWait {
            do {
                employees = try mainContext.fetch(fetchRequest)
            } catch let error {
                print("Failed to fetch companies: \(error)")
            }
        }
        
        return employees
    }
}

