//
//  InsertDeletingRowsEditMode.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-11.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

/*
 This viewController demonstrates what it looks like to delete a `UITableView` row
 by setting `tableView.isEditing = true`.

 Note: You can supply your own barButton item and action to trigger edit mode, or
       use a built in one (editButtonItem) built into `UINavigationController` which
       calls `setEditing` on your VC for you.
 */

class SimpleListEditModeViewController: UIViewController {

    var games = ["Space Invaders",
                "Dragon Slayer",
                "Disks of Tron",
                "Moon Patrol",
                "Galaga"]

    var tableView = UITableView()
    let cellId = "insertCellId"

    lazy var myButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(myButtonTapped))
        barButtonItem.tintColor = UIColor.systemBlue
        return barButtonItem
    }()
    
    // MARK: - Actions

    @objc
    func myButtonTapped() {
        tableView.isEditing = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Classic Arcade"
//         navigationItem.rightBarButtonItem = myButtonItem
        navigationItem.rightBarButtonItem = editButtonItem // magic!

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        view = tableView
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

}

// MARK:  - UITableView Delegate

extension SimpleListEditModeViewController: UITableViewDelegate {

}

// MARK:  - UITableView DataSource

extension SimpleListEditModeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.none

        return cell
    }

    // To trigger single action insert mode.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            addGame("Ms Pacman")
        }
    }

    private func addGame(_ game: String) {
        games.append(game)

        let indexPath = IndexPath(row: games.count - 1, section: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

}
