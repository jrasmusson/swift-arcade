//
//  ViewController.swift
//  SimpleAppExtractViewController
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-05-11.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let cellId = "cellId"
    var tableView = UITableView()

    var gameView = GameView()
    var gameTableViewController = GameTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }

    func setup() {
        gameTableViewController.delegate = self
    }
    
    func layout() {
        gameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameView)

        // x3 things with nested childViewControllers
        view.addSubview(gameTableViewController.view)
        addChild(gameTableViewController)
        gameTableViewController.didMove(toParent: self)

        guard let gameTableView = gameTableViewController.view else { return }
        gameTableView.translatesAutoresizingMaskIntoConstraints = false

        gameView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        gameView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: gameView.trailingAnchor, multiplier: 3).isActive = true

        gameTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        gameTableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: gameTableView.trailingAnchor, multiplier: 1).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: gameTableView.bottomAnchor, multiplier: 1).isActive = true
    }
}

extension ViewController: GameTableViewControllerDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        let game = gameTableViewController.games[indexPath.row]

        gameView.alpha = 0

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, options: [], animations: {
            self.gameView.game = game
            self.gameView.alpha = 1
        })
    }
}
