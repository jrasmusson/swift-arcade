//
//  ViewController.swift
//  FloatingButton
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-08.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        style()
        layout()
    }
    
    struct ButtonSpacing {
        static let height: CGFloat = 40
        static let width: CGFloat = 100
    }
    
    func style() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Float", for: .normal)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = ButtonSpacing.height / 2
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(tableView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.widthAnchor.constraint(equalToConstant: ButtonSpacing.width),
            button.heightAnchor.constraint(equalToConstant: ButtonSpacing.height),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupTable() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
