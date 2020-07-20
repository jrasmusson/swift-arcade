//
//  ViewController.swift
//  HistorySpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-20.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

struct History : Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let id: Int
    let description: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case description
        case id
        case date = "processed_at"
    }
}

class HistoryViewController: UITableViewController {
    
    let games = ["Pacman",
                 "Space Invaders",
                 "Space Patrol",
                 "Galaga",
                 "Donkey Kong"]
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    func style() {
        navigationItem.title = "History"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: Data Source
extension HistoryViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}
