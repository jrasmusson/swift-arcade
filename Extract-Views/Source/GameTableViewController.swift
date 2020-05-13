//
//  GameTableView.swift
//  SimpleAppExtractViewController
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-05-11.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

struct Game {
    let name: String
    let description: String
    let imageName: String
}

protocol GameTableViewControllerDelegate: AnyObject {
    func didSelectRowAt(indexPath: IndexPath)
}

class GameService {

    func fetchGames(completion: @escaping ((Result<[Game], Error>) -> Void)) {
        let games = [Game(name: "Space Invaders", description: "Space Invaders is a Japanese shooting video game released in 1978 by Taito. It was developed by Tomohiro Nishikado, who was inspired by other media: Breakout, The War of the Worlds, and Star Wars.", imageName: "space-invaders"),
                     Game(name: "Discs of Tron", description: "Discs of Tron, is the second arcade game based on the Disney film Tron. While the first Tron arcade game had several mini-games based on scenes in the movie, Discs of Tron is a single game inspired by Tron's disc-battle sequences and set in an arena similar to the one in the Jai Alai–style sequence. ", imageName: "tron"),
                     Game(name: "Frogger", description: "Frogger is a 1981 arcade game developed by Konami and originally published by Sega. In North America, it was published jointly by Sega and Gremlin Industries. The object of the game is to direct frogs to their homes one by one by crossing a busy road and navigating a river full of hazards.", imageName: "frogger"),
                     Game(name: "Joust", description: "Joust is an arcade game developed by Williams Electronics and released in 1982. It popularized the concept of two-player cooperative gameplay by being more successful at it than its predecessors. The player uses a button and joystick to control a knight riding a flying ostrich.", imageName: "joust")
                    ]

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(Result.success(games))
        }
    }
}

class GameTableViewController: UIViewController {

    let cellId = "cellId"
    var tableView = UITableView()
    var games = [Game]()

    weak var delegate: GameTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        layout()
        loadData()
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    func loadData() {
        GameService().fetchGames { [weak self] result in
            switch result {
            case .success(let games):
                self?.games = games
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // Option 1: Pin to x4 sides of view.
    func layout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    // Option 2: Pin automatically via loadView()
    override func loadView() {
        view = tableView
    }
}

extension GameTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
}

extension GameTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}
