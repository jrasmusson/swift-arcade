//
//  MediumEmployeeManagerTest.swift
//  CoreDataUnitTestTests
//
//  Created by jrasmusson on 2020-11-29.
//

import XCTest
import CoreData
@testable import CoreDataUnitTest

/*
 Here we avoid colliding with the app data by:
 
 - creating a new CoreDataManagerTest which sets up it's own in-memory viewContext (mainthread)
 - still doing everything on the main thread
 
 */
class MediumEmployeeManagerTests: XCTestCase {
            
    var employeeManager: MediumEmployeeManager!
    var coreDataStack: CoreDataTestStack!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        employeeManager = MediumEmployeeManager(mainContext: coreDataStack.mainContext)
    }

    func test_create_employee() {
        employeeManager.createEmployee(firstName: "Jon")
        let employee = employeeManager.fetchEmployee(withName: "Jon")!

        XCTAssertEqual("Jon", employee.firstName)
    }
        
    func test_update_employee() {
        let employee = employeeManager.createEmployee(firstName: "Jon")!
        employee.firstName = "Jonathan"
        employeeManager.updateEmployee(employee: employee)
        let updated = employeeManager.fetchEmployee(withName: "Jonathan")!
        
        XCTAssertNil(employeeManager.fetchEmployee(withName: "Jon"))
        XCTAssertEqual("Jonathan", updated.firstName)
    }

    func test_delete_employees() {

        let employeeA = employeeManager.createEmployee(firstName: "A")!
        let employeeB = employeeManager.createEmployee(firstName: "B")!
        let employeeC = employeeManager.createEmployee(firstName: "C")!

        employeeManager.deleteEmployee(employee: employeeB)

        let employees = employeeManager.fetchEmployees()!
        
        XCTAssertEqual(employees.count, 2)
        XCTAssertTrue(employees.contains(employeeA))
        XCTAssertTrue(employees.contains(employeeC))
    }
}

