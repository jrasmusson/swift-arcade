//
//  ViewController.swift
//  SimpleInsert
//
//  Created by Rasmusson, Jonathan on 2021-09-03.
//

import UIKit

class ViewController: UIViewController {

    var games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]

    lazy var addBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigationBar()
    }

    @objc func addTapped(_ sender: UIBarButtonItem) {
        games.append("Tron")
        games.append("Dig Dug")
        games.append("Moon Patrol")

        let indexPath3 = IndexPath(row: games.count - 3, section: 0)
        let indexPath2 = IndexPath(row: games.count - 2, section: 0)
        let indexPath1 = IndexPath(row: games.count - 1, section: 0)

//        let indexPath3 = IndexPath(row: 0, section: 0)
//        let indexPath2 = IndexPath(row: 1, section: 0)
//        let indexPath1 = IndexPath(row: 2, section: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath1, indexPath2, indexPath3], with: .fade)
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

// MARK: Setup
extension ViewController {
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }

    private func setupNavigationBar() {
        title = "Games"
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}
