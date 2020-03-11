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
        view = tableView
    }

    // MARK: - Actions

    @objc
    func addButtonPressed() {
    }

    private func addGame(_ game: String) {
        games.append(game)

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
        cell.accessoryType = UITableViewCell.AccessoryType.none

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

// Protocol
// -insertGame inListAtIndex: Int

protocol InsertDeletingRowsEditModeDelegate: AnyObject {
    func insert(game: String, inListAtIndex: Int)
}

extension InsertDeletingRowsEditMode: InsertDeletingRowsEditModeDelegate {
    func insert(game: String, inListAtIndex: Int) {
        addGame(game)
    }
}


// U R HERE - Insert
// Create a new ViewController for adding a new game
// present it modally when Add pressed
// Dismiss and return with new role added
// Show two ways of doing this
// 1. As you currently do
// 2. With a modal popover

// Create a directory and show both separately

