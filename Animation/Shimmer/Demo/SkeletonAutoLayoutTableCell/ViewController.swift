//
//  ViewController.swift
//  SkeletonAutoLayoutTableCell
//
//  Created by jrasmusson on 2021-02-24.
//

import UIKit

struct Game {
    let title: String
    let year: String
    init(_ name: String, _ year: String) {
        self.title = name
        self.year = year
    }
}

class ViewController: UIViewController {

    let games = [
                Game("Pacman", "1980"),
                Game("Space Invaders", "1978"),
                Game("Frogger", "1981")
    ]
    
    let cellId = "cellId"
    let skeletonCellId = "skeletonCellId"
    var tableView = UITableView()
    
    var loaded = false
    
    lazy var loadButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Load", style: .plain, target: self, action: #selector(loadTapped))
            return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        title = "Skeleton Demo"
        navigationItem.rightBarButtonItem = loadButtonItem
        
        tableView.dataSource = self

        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: skeletonCellId)
        tableView.tableFooterView = UIView()
        
        view = tableView
    }
    
    @objc func loadTapped() {
        loaded = !loaded
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
            cell.game = games[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: skeletonCellId, for: indexPath) as! SkeletonCell
            cell.game = games[indexPath.row]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}
