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
        return makeSymbolButton(systemName: "plus", target: self, selector: #selector(addEmployeePressed))
    }()

    let minusButton: UIButton = {
        return makeSymbolButton(systemName: "minus", target: self, selector: #selector(deleteEmployeePressed))
    }()

    let countLabel: UILabel = {
        let label = makeLabel(withTitle: "XXX")
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        populateViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Intro"

        let rootStackView = makeVerticalStackView()

        let buttonStackView = makeHorizontalStackView()
        buttonStackView.addArrangedSubview(plusButton)
        buttonStackView.addArrangedSubview(minusButton)

        rootStackView.addArrangedSubview(buttonStackView)

        view.addSubview(rootStackView)

        rootStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rootStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 3).isActive = true


        plusButton.widthAnchor.constraint(equalTo: minusButton.widthAnchor).isActive = true
    }

    func populateViews() {
        countLabel.text = "1"
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
