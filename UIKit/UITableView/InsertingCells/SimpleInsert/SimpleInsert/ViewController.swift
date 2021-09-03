//
//  ViewController.swift
//  SimpleInsert
//
//  Created by Rasmusson, Jonathan on 2021-09-03.
//

import UIKit

class ViewController: UIViewController {

    var data = [
        "Pacman",
        "Frogger",
        "Galaga",
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
        data.append("Tron")
        data.append("Defender")
        data.append("Joust")

        let indexPath1 = IndexPath(row: data.count - 1, section: 0) // Tron
        let indexPath2 = IndexPath(row: data.count - 2, section: 0) // Defender
        let indexPath3 = IndexPath(row: data.count - 3, section: 0) // Joust


        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath1, indexPath2, indexPath3], with: .fade)
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
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
