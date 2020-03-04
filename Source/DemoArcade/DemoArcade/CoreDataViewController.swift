//
//  CoreDataViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class CoreDataViewController: UIViewController {

    let plusButton: UIButton = {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addEmployeePressed), for: .primaryActionTriggered)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit

        return button
    }()

    let minusButton: UIButton = {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "minus", withConfiguration: configuration)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteEmployeePressed), for: .primaryActionTriggered)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        DemoCoreData()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Intro"

        let stackView = makeRowStackView()
        stackView.addArrangedSubview(plusButton)
        stackView.addArrangedSubview(minusButton)
        
        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3).isActive = true
    }

    // MARK: Actions

    @objc
    func addEmployeePressed() {
        print("Add")
    }

    @objc
    func deleteEmployeePressed() {
        print("Delete")
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
