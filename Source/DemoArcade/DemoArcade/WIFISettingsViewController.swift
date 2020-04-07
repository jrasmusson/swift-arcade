//
//  WiFiViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-07.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

/*
Abstract:
  Mimics the Settings.app for displaying a dynamic list of available wi-fi access points
*/

import UIKit

class WIFISettingsViewController: UIViewController {

    enum Section: CaseIterable {
        case networks
    }

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var dataSource: UITableViewDiffableDataSource<Section, Network>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Network>! = nil
    var wifiController: WIFIController! = nil
    
    let reuseIdentifier = "reuse-identifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Wi-Fi"
        configureTableView()
        configureDataSource()
        updateUI(animated: false)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    func configureDataSource() {
        
        wifiController = WIFIController { [weak self] (controller: WIFIController) in
            guard let self = self else { return }
            self.updateUI()
        }
        
        self.dataSource = UITableViewDiffableDataSource<Section, Network>(tableView: tableView) {
                (tableView: UITableView, indexPath: IndexPath, item: Network) -> UITableViewCell? in

            let cell = tableView.dequeueReusableCell(
                withIdentifier: self.reuseIdentifier,
                for: indexPath)

                cell.textLabel?.text = item.name
                cell.accessoryType = .detailDisclosureButton
                cell.accessoryView = nil

            return cell
        }
        
        self.dataSource.defaultRowAnimation = .fade
    }

    func updateUI(animated: Bool = true) {
        guard let controller = self.wifiController else { return }

        currentSnapshot = NSDiffableDataSourceSnapshot<Section, Network>()
        
        let sortedNetworks = controller.availableNetworks.sorted { $0.name < $1.name }
        
        currentSnapshot.appendSections([.networks])
        currentSnapshot.appendItems(sortedNetworks, toSection: .networks)
        
        self.dataSource.apply(currentSnapshot, animatingDifferences: animated)
    }

}
