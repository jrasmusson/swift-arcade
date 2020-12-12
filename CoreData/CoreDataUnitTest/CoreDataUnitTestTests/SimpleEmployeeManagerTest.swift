//
//  SimpleEmployeeManagerTest.swift
//  CoreDataUnitTestTests
//
//  Created by jrasmusson on 2020-11-29.
//

import XCTest
import CoreData
@testable import CoreDataUnitTest

/*
 If we naively test with CoreData we run into the problem of our test
 data mixing with our app data due to both sharing the same context.
 
 What we want is a separate in-memory context that wipes itself clean every time.
 
 */
class SimpleEmployeeManagerTests: XCTestCase {
        
    var employeeManager: SimpleEmployeeManager!

    override func setUp() {
        super.setUp()
        employeeManager = SimpleEmployeeManager()
    }
    
    func test_create_employee() {
        employeeManager.createEmployee(firstName: "Jon")
        let employee = employeeManager.fetchEmployee(withName: "Jon")!

        XCTAssertEqual("Jon", employee.firstName)
    }
        
    // These demo purposes these fail
    func test_update_Employee() {
        let employee = employeeManager.createEmployee(firstName: "Jon")!
        employee.firstName = "Jonathan"
        employeeManager.updateEmployee(employee: employee)
        let updated = employeeManager.fetchEmployee(withName: "Jonathan")!

        XCTAssertNil(employeeManager.fetchEmployee(withName: "Jon")!)
        XCTAssertEqual("Jonathan", updated.firstName)
    }

    func test_delete_and_read_Employees() {

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
