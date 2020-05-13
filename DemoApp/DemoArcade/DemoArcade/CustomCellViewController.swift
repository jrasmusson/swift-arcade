//
//  CustomCellViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-24.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

struct Channel {
    let imageName: String
    let name: String
    let price: String
}

let channel1 = Channel(imageName: "netflix", name: "Netflix", price: "$8/month")

var channels = [channel1]

class CustomCellViewController: UIViewController {

    let cellId = "cellId"

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }

    func setup() {
        view.backgroundColor = .white
        navigationItem.title = "Custom Cell"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChannelCell.self, forCellReuseIdentifier: cellId)
    }

    func layout() {
        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0).isActive = true

        tableView.reloadData()
    }
}

// MARK:  - UITableView Delegate

extension CustomCellViewController: UITableViewDelegate {

}

// MARK:  - UITableView DataSource

extension CustomCellViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChannelCell

        let channel = channels[indexPath.row]
        cell.channel = channel

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

