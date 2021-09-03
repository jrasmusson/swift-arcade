//
//  ViewController.swift
//  LargeTitles
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-24.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var inboxBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Inbox", style: .plain, target: self, action: #selector(inboxTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    lazy var historyBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(historyTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    @objc func inboxTapped() {}
    @objc func historyTapped() {}

    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
        "Galaga",
        "Donkey Kong",
        "Frogger",
        "Defender",
        "Dig Dug",
        "Zaxxon",
        "Qbert",
        "Burger Time",
        "Joust",
        "Paperboy",
        "Missle Command",
        "Pole Position",
        "Robotron",
        "Spy Hunter",
        "Star Wars",
        "1942",
        "Dragon's Lair",
        "Moon Patrol",
        "Centipede",
        "Bezerk",
        "Elevator Action",
        "Gauntlet",
        "Sinistar",
        "Tempest",
    ]
    
    let cellId = "cellId"

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
    }
    
    func setupNavBar() {
        title = "Good afternoon, Jonathan ☀️"
        //        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsOnTap = true
        
        navigationItem.leftBarButtonItems = [inboxBarButtonItem, historyBarButtonItem]
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        tableView.tableFooterView = UIView() // hide empty rows

        view = tableView
    }

}

extension ViewController: UITableViewDelegate {

}

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

}
