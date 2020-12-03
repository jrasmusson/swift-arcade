//
//  ColorsDataManagerTests.swift
//  CoreDataUnitTestTests
//
//  Created by jrasmusson on 2020-11-15.
//

import XCTest
import CoreData
@testable import CoreDataUnitTest

/*
 Even though the ComplexEmployeeManager runs on a background thread, we can force it
 to run the main thread (where our unit tests run) by passing in a mainContext.
 */
class ComplexEmployeeManagerTest: XCTestCase {
    
    var employeeManager: ComplexEmployeeManager!
    var coreDataStack: CoreDataTestStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        employeeManager = ComplexEmployeeManager(mainContext: coreDataStack.mainContext,
                                                 backgroundContext: coreDataStack.mainContext)
    }
    
    func test_create_employee() {
        employeeManager.createEmployee(firstName: "Jon")
        let employee = employeeManager.fetchEmployee(withName: "Jon")!

        XCTAssertEqual("Jon", employee.firstName)
    }
        
    func test_delete_employee() {
        employeeManager.createEmployee(firstName: "A")
        employeeManager.createEmployee(firstName: "B")
        employeeManager.createEmployee(firstName: "C")

        let employeeA = employeeManager.fetchEmployee(withName: "A")!
        let employeeB = employeeManager.fetchEmployee(withName: "B")!
        let employeeC = employeeManager.fetchEmployee(withName: "C")!
        
        employeeManager.deleteEmployee(employee: employeeB)

        let employees = employeeManager.fetchEmployees()!
        
        XCTAssertEqual(employees.count, 2)
        XCTAssertTrue(employees.contains(employeeA))
        XCTAssertTrue(employees.contains(employeeC))
    }
}
