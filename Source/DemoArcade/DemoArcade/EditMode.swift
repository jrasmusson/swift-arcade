//
//  EditMode.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

/*
Abstract:
Sample demonstrating UITableViewDiffableDataSource using editing, reordering and header/footer titles support
*/

import UIKit

class EditMode: UIViewController {

    enum Section: Int {
        case visited = 0, bucketList
        func description() -> String {
            switch self {
            case .visited:
                return "Visited"
            case .bucketList:
                return "Bucket List"
            }
        }
        func secondaryDescription() -> String {
            switch self {
            case .visited:
                return "Trips I've made!"
            case .bucketList:
                return "Need to do this before I go!"
            }
        }
    }
    
    typealias SectionType = Section
    typealias ItemType = MountainsController.Mountain
    
    let reuseIdentifier = "reuse-id"
    
    // Subclassing our data source to supply various UITableViewDataSource methods
    
    class MoveableCellDataSource: UITableViewDiffableDataSource<SectionType, ItemType> {
        
        // MARK: header/footer titles support
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.secondaryDescription()
        }
        
        // MARK: reordering support
        
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

            // get our source & destination (from & to)
            guard let sourceIdentifier = itemIdentifier(for: sourceIndexPath) else { return }
            guard sourceIndexPath != destinationIndexPath else { return }
            let destinationIdentifier = itemIdentifier(for: destinationIndexPath)
            
            // take snapshot before
            var snapshot = self.snapshot()

            // if moving with a section
            if let destinationIdentifier = destinationIdentifier {
                
                guard let sourceIndex = snapshot.indexOfItem(sourceIdentifier) else { return }
                guard let destinationIndex = snapshot.indexOfItem(destinationIdentifier) else { return }

                // delete it
                snapshot.deleteItems([sourceIdentifier])

                // figure out if before or after (and double check same section)
                let isAfter = destinationIndex > sourceIndex &&
                    snapshot.sectionIdentifier(containingItem: sourceIdentifier) ==
                    snapshot.sectionIdentifier(containingItem: destinationIdentifier)
                                
                // insert back either before or after
                if isAfter {
                    snapshot.insertItems([sourceIdentifier], afterItem: destinationIdentifier)
                } else {
                    snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
                }

            }
            // move between sections
            else {
                // get the new destination section
                let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
                // delete where it was
                snapshot.deleteItems([sourceIdentifier])
                // add to where it is going
                snapshot.appendItems([sourceIdentifier], toSection: destinationSectionIdentifier)
            }
            
            apply(snapshot, animatingDifferences: false)
        }
        
        // MARK: editing support

        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            // when deleting a row...
            if editingStyle == .delete {
                if let identifierToDelete = itemIdentifier(for: indexPath) {
                    var snapshot = self.snapshot()
                    snapshot.deleteItems([identifierToDelete])
                    apply(snapshot)
                }
            }
        }
    }
    
    var dataSource: MoveableCellDataSource!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        configureNavigationItem()
    }
}

extension EditMode {
    func configureHierarchy() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        let formatter = NumberFormatter()
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        
        // data source
        
        dataSource = MoveableCellDataSource(tableView: tableView) { (tableView, indexPath, mountain) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: self.reuseIdentifier)
            }

            cell.textLabel?.text = mountain.name

            if let formattedHeight = formatter.string(from: NSNumber(value: mountain.height)) {
                cell.detailTextLabel?.text = "\(formattedHeight)M"
            }

            return cell
        }
        
        // initial data
        
        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func initialSnapshot() -> NSDiffableDataSourceSnapshot<SectionType, ItemType> {
        let mountainsController = MountainsController()
        let limit = 8
        let mountains = mountainsController.filteredMountains(limit: limit)
        let bucketList = Array(mountains[0..<limit / 2])
        let visited = Array(mountains[limit / 2..<limit])

        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.visited])
        snapshot.appendItems(visited)
        snapshot.appendSections([.bucketList])
        snapshot.appendItems(bucketList)
        return snapshot
    }
    
    func configureNavigationItem() {
        navigationItem.title = "UITableView: Editing"
        let editingItem = UIBarButtonItem(title: tableView.isEditing ? "Done" : "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItems = [editingItem]
    }
    
    @objc
    func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        configureNavigationItem()
    }
}


