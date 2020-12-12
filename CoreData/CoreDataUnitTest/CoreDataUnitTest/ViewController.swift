//
//  ViewController.swift
//  CoreDataUnitTest
//
//  Created by jrasmusson on 2020-11-15.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let manager = SimpleEmployeeManager()
//    let manager = MediumEmployeeManager()
//    let manager = ComplexEmployeeManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Simple
        manager.createEmployee(firstName: "Jon")
        let jon = manager.fetchEmployee(withName: "Jon")!
        
        manager.updateEmployee(employee: jon)
        manager.deleteEmployee(employee: jon)
    }

}

