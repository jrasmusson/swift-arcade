//
//  AppendViewController.swift
//  SimpleInsert
//
//  Created by Rasmusson, Jonathan on 2021-09-03.
//

/*
 With this technique we don't worry about index paths.
 Instead we continuously append new data rows to our existing data
 and then simply re-render the entire table.

 This is much simpler and it maintains the scroll position of where you are.
 The only thing you lose is the animation of the new rows being added.
 */
import UIKit

class AppendViewController: UIViewController {

    var data = [
        "Pacman",
        "Frogger",
        "Galaga",
    ]

    var newData = [
        "Tron",
        "Defender",
        "Joust",
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
        data.append(contentsOf: newData)
        tableView.reloadData()
    }
}

extension AppendViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = data[indexPath.row]
        print("Game: \(game) indexPath: \(indexPath.row)")
    }
}

// MARK: Setup
extension AppendViewController {
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
