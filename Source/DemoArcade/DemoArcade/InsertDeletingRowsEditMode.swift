//
//  InsertDeletingRowsEditMode.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-11.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class InsertDeletingRowsEditMode: UIViewController {

    var games = ["Space Invaders",
                "Dragon Slayer",
                "Disks of Tron",
                "Moon Patrol",
                "Galaga"]

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textAlignment = .center
        textField.backgroundColor = .systemFill

        return textField
    }()

    lazy var editButton: UIButton = {
        let button = makeButton(withText: "Edit")
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(editButtonPressed), for: .primaryActionTriggered)

        return button
    }()

    lazy var cancelEditButton: UIButton = {
        let button = makeButton(withText: "Cancel")
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(cancelEditButtonPressed), for: .primaryActionTriggered)

        return button
    }()

    lazy var addButton: UIButton = {
        let button = makeButton(withText: "Add")
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(addButtonPressed), for: .primaryActionTriggered)

        return button
    }()

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    let cellId = "insertCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layout()
    }

    func setupViews() {
        navigationItem.title = "Classic Arcade"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    func layout() {
        let rootStackView = makeVerticalStackView()

        let addStackView = makeHorizontalStackView()
        addStackView.addArrangedSubview(textField)
        addStackView.addArrangedSubview(addButton)

        let editCancelStackView = makeHorizontalStackView()
        editCancelStackView.addArrangedSubview(editButton)
        editCancelStackView.addArrangedSubview(cancelEditButton)
        editButton.widthAnchor.constraint(equalTo: cancelEditButton.widthAnchor, multiplier: 1).isActive = true
        cancelEditButton.isHidden = true

        rootStackView.addArrangedSubview(addStackView)
        rootStackView.addArrangedSubview(editCancelStackView)
        rootStackView.addArrangedSubview(tableView)

        view.addSubview(rootStackView)

        rootStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 1).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: rootStackView.bottomAnchor, multiplier: 1).isActive = true
    }

    // MARK: - Actions

    @objc
    func editButtonPressed() {
        tableView.isEditing = true
        editButton.isEnabled = false
        editButton.backgroundColor = .systemFill
        cancelEditButton.isHidden = false
    }

    @objc
    func cancelEditButtonPressed() {
        tableView.isEditing = false
        editButton.isEnabled = true
        editButton.backgroundColor = .systemBlue
        cancelEditButton.isHidden = true
    }

    @objc
    func addButtonPressed() {
        insertTextBottomRow()
    }

    private func insertTextBottomRow() {
        guard let text = textField.text else { return }
        games.append(text)

        let indexPath = IndexPath(row: games.count - 1, section: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

// MARK:  - UITableView Delegate

extension InsertDeletingRowsEditMode: UITableViewDelegate {

}

// MARK:  - UITableView DataSource

extension InsertDeletingRowsEditMode: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

