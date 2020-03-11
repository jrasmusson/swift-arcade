//
//  InsertDeleteTableViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class SwipingCellsTableViewController: UIViewController {

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
        let addStackView = makeHorizontalStackView()
        addStackView.addArrangedSubview(textField)
        addStackView.addArrangedSubview(addButton)

        view.addSubview(addStackView)
        view.addSubview(tableView)

        addStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        addStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: addStackView.trailingAnchor, multiplier: 3).isActive = true

        tableView.topAnchor.constraint(equalToSystemSpacingBelow: addStackView.bottomAnchor, multiplier: 1).isActive = true
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 1).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1).isActive = true
    }

    // MARK: - Actions

    // 3. Custom target action
    @objc
    func addButtonPressed() {
        guard let text = textField.text else { return }
        games.append(text)

        let indexPath = IndexPath(row: games.count - 1, section: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

// MARK:  - UITableView Delegate

extension SwipingCellsTableViewController: UITableViewDelegate {

}

// MARK:  - UITableView DataSource

extension SwipingCellsTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }
    
    /*
     You basically have three options when it comes to inserting/deleting cells.
     
     1. Edit styling.
     2. Edit actions for row (overrides #1).
     3. Custom target action.
     
     */

    // 1. Edit styling.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // 2. Edit actions for row.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

        let share = UITableViewRowAction(style: .normal, title: "Disable") { (action, indexPath) in
            // share item at indexPath
        }

        share.backgroundColor = UIColor.blue

        return [delete, share]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
