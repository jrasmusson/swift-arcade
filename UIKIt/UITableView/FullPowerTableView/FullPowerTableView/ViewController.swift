//
//  ViewController.swift
//  FullPowerTableView
//
//  Created by jrasmusson on 2021-08-22.
//

import UIKit

class ViewController: UIViewController {
    
    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]
    
    @IBOutlet var tableView: UITableView!
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Setup
extension ViewController {
    func setup() {
        setupTableView()
        setupTableViewHeader()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView() // hide empty rows
    }
    
    private func setupTableViewHeader() {
        let header = HeaderView(frame: .zero)

        // Set frame size before populate view to have initial size
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size

        // Recalculate header size after populated with content
        size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size

        tableView.tableHeaderView = header
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
