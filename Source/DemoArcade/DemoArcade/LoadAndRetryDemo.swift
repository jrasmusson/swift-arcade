//
//  LoadRetryDemo.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class LoadAndRetryDemo: FullscreenLockController {

    var games: [String] = []

    let cellId = "cellId"

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    lazy var fetchButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(fetchButtonTapped))
        barButtonItem.tintColor = UIColor.systemBlue
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layout()
    }

    func setupViews() {
        navigationItem.title = "Retry Loading Screen"
        navigationItem.rightBarButtonItem = fetchButtonItem

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    func layout() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func loadData() {
        setToLoading()

        fetchData { result in
            self.doneLoading()

            switch result {
            case .success(let games):
                self.games = games
                self.tableView.reloadData()
            case .failure(_):
                self.setToRetry()
            }
        }
    }

    func loadDataFailure() {
        setToLoading()

        fetchData { result in
            self.doneLoading()
            self.setToRetry()
        }
    }

    func fetchData(completion: (Result<[String], Error>) -> Void) {
        enum FetchError: Error {
            case failed
        }

        let games = ["Space Invaders", "Dragon Slayer", "Disks of Tron", "Moon Patrol", "Galaga"]

        completion(Result.success(games))
//        completion(Result.failure(FetchError.failed))
    }

    @objc func fetchButtonTapped() {
        loadDataFailure()
    }

}

extension LoadAndRetryDemo: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension LoadAndRetryDemo: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

// MARK: - Retry Responder Chain Callback

extension LoadAndRetryDemo: FailableView {
    func retry(sender: Any?) {
        loadData()
    }
}

