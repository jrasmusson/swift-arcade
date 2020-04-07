//
//  MountainTableViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-07.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class MountainTableViewController: UIViewController {

    enum Section {
        case main
    }
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var dataSource: UITableViewDiffableDataSource<Section, MountainsController.Mountain>!
    var nameFilter: String?
    
    let reuseIdentifier = "reuse-identifier"
    
    let mountainsController = MountainsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mountains Search"
        
        layout()
        configureDataSource()
        performQuery(with: nil)
    }
    
    func layout() {
        for viewable in [searchBar, tableView] {
            view.addSubview(viewable)
            viewable.translatesAutoresizingMaskIntoConstraints = false
        }
        
        searchBar.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        searchBar.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        searchBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchBar.trailingAnchor, multiplier: 1).isActive = true
        
        tableView.topAnchor.constraint(equalToSystemSpacingBelow: searchBar.bottomAnchor, multiplier: 0).isActive = true
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0).isActive = true
    }
    
    func configureDataSource() {
                
        dataSource = UITableViewDiffableDataSource<Section, MountainsController.Mountain>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, item: MountainsController.Mountain) -> UITableViewCell?  in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = item.name
            return cell
        }
        
    }
        
    func performQuery(with filter: String?) {
        let mountains = mountainsController.filteredMountains(with: filter).sorted { $0.name < $1.name }

        var snapshot = NSDiffableDataSourceSnapshot<Section, MountainsController.Mountain>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mountains, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MountainTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}

