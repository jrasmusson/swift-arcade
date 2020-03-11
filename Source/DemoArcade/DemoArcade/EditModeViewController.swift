//
//  InsertDeletingRowsEditMode.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-11.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class EditModeViewController: UIViewController {

    var games = ["Space Invaders",
                "Dragon Slayer",
                "Disks of Tron",
                "Moon Patrol",
                "Galaga"]

    var tableView = UITableView()
    let cellId = "insertCellId"

    let saveGameViewController = SaveGameViewController()

    lazy var addGameButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addGameTapped))
        barButtonItem.tintColor = UIColor.systemBlue
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Classic Arcade"
        navigationItem.rightBarButtonItem = addGameButtonItem

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        saveGameViewController.delegate = self

        view = tableView
    }

    // MARK: - Actions

    @objc
    func addGameTapped() {
        present(saveGameViewController, animated: true, completion: nil)
    }

    private func addGame(_ game: String) {
        games.append(game)

        let indexPath = IndexPath(row: games.count - 1, section: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

// MARK:  - SaveGameViewController Delegate

extension EditModeViewController: SaveGameViewControllerDelegate {
    func insert(game: String) {
        addGame(game)
    }
}

// MARK:  - UITableView Delegate

extension EditModeViewController: UITableViewDelegate {

}

// MARK:  - UITableView DataSource

extension EditModeViewController: UITableViewDataSource {

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
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
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

