//
//  MediumEmployeeManager.swift
//  CoreDataUnitTest
//
//  Created by jrasmusson on 2020-11-29.
//

import Foundation
import CoreData

/*
 This manager also works purely on the `mainContext`.
 The one difference is it's context can be set externally.
 Meaning if you wanted to pass in a context configured purely for in-memory you could.
 
 This enables you to write unit tests that don't collide with app data.
 We well as run them quickly in memory.
 
 */

struct MediumEmployeeManager {
    
    let mainContext: NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.mainContext = mainContext
    }

    @discardableResult
    func createEmployee(firstName: String) -> Employee? {
        let employee = Employee(context: mainContext)
        
        employee.firstName = firstName
        
        do {
            try mainContext.save()
            return employee
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        return nil
    }
    
    func fetchEmployees() -> [Employee]? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            let employees = try mainContext.fetch(fetchRequest)
            return employees
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    func fetchEmployee(withName name: String) -> Employee? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "firstName == %@", name)
        
        do {
            let employees = try mainContext.fetch(fetchRequest)
            return employees.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    func updateEmployee(employee: Employee) {
        do {
            try mainContext.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
    func deleteEmployee(employee: Employee) {
        mainContext.delete(employee)
        
        do {
            try mainContext.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
}

