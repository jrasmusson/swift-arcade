//
//  SimpleEmployeeManager.swift
//  CoreDataUnitTest
//
//  Created by jrasmusson on 2020-11-29.
//

import Foundation
import CoreData

/*
 This manager only uses the main thread viewContext.
 
 Simple. It works. But will experience data collisions when writing unit tests.
 
 */
struct SimpleEmployeeManager {
        
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MyData")
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
    }
    
    @discardableResult
    func createEmployee(firstName: String) -> Employee? {
        let context = persistentContainer.viewContext
        
        let employee = Employee(context: context)
        
        employee.firstName = firstName
        
        do {
            try context.save()
            return employee
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        return nil
    }
    
    func fetchEmployees() -> [Employee]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            let employees = try context.fetch(fetchRequest)
            return employees
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    func fetchEmployee(withName name: String) -> Employee? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "firstName == %@", name)
        
        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    func updateEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
    func deleteEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        context.delete(employee)
        
        do {
            try context.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
}
