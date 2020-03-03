//
//  CoreDataViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class CoreDataViewController: UIViewController {

    let cityLabel: UILabel = {
        let label = makeLabel(withTitle: "This demo shows CoreData CRUD without any UI. Run the app repeatedly, check print statement output, and see how CoreData saves state between sessions.")
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        DemoCoreData()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Closures"

        view.addSubview(cityLabel)
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        cityLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: cityLabel.trailingAnchor, multiplier: 3).isActive = true
    }

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

}

// Add a UI to this to create / delete employees and spit out number
