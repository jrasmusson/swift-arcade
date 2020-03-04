//
//  CoreDataManager.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

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

    // U R HERE - create EmployeeManager
    
    func createEmployee(name: String) -> Employee? {
        let context = persistentContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee

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

        employee.name = "Peter"

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

