//
//  DemoViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-02-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

struct Lab {
    let name: String
    let viewController: UIViewController
}

class DemoViewController: UITableViewController {

    var labs: [Lab]
    var navBarTitle: String

    let cellId = "cellId"

    init(labs: [Lab], navBarTitle: String) {
        self.labs = labs
        self.navBarTitle = navBarTitle

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = navBarTitle
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = labs[indexPath.row].name

        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labs.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(labs[indexPath.row].viewController, animated: true)
    }
}

