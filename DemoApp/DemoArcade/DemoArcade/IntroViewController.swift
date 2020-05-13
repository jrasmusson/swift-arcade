//
//  CRUDViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-05.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    let label: UILabel = {
        let label = makeLabel(withTitle: "Demo showing CRUD - see code and print statements.")
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        demoCoreData()
    }

    func setupViews() {
        navigationItem.title = "Intro"

        view.addSubview(label)
        
        label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 3).isActive = true
    }

    func demoCoreData() {
        // Create
        guard let newEmployee = CoreDataManager.shared.createEmployee(name: "Jon") else { return }
        print(newEmployee)
        
        // Read
        guard let employee = CoreDataManager.shared.fetchEmployee(withName: "Jon") else { return }
        guard let employees = CoreDataManager.shared.fetchEmployees() else { return }
        _ = employees.map { print($0.name ?? "") }

        // Update
        employee.name = "Peter"
        CoreDataManager.shared.updateEmployee(employee: employee)
        guard let updatedEmployee = CoreDataManager.shared.fetchEmployee(withName: "Peter") else { return }
        print("Updated: \(updatedEmployee)")
        
        // Delete
        CoreDataManager.shared.deleteEmployee(employee: updatedEmployee)

        print("Number employees: \(employees.count)")
    }

}

