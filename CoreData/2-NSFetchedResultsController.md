# Getting started with NSFetchResultsController

Simple example of how to use in a _UIViewController_ with a CoreData _Entity_ called _Game_.

<img src="https://github.com/jrasmusson/swift-arcade/blob/master/CoreData/images/NSFetchedResultsController.png" alt="drawing" width="400"/>

Create variable.

```swift
var fetchedResultsController: NSFetchedResultsController<Game>!
```

Load via CoreData. Here you can specify how you would like your results to be fetched, give a sort description, and limit the number of results coming back while also setting yourself up as the delegate to receive callbacks. This is also where we load the _tableView_ data.

```swift
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = NSFetchRequest<Game>(entityName: "Game")
            let sort = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20

            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }

        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
```

When add button is pressed, we can create a new _Game_ _Entitiy_ via CoreData.

```swift
    @objc
    func addButtonPressed() {
        guard let name = textField.text else { return }

        // 4 CoreData viewContext > NSFetchRequest > Delegate (us)
        GameManager.shared.createGame(name: name)
	 }
```

In the _UIDataSource_ we get the data for our tableCell from the _fetchResultsController_.

```swift
extension DemoFetchedResultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // 5
        // cell.textLabel?.text = games[indexPath.row]
        let game = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = game.name

        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        return cell
    }
```

Then we can add our _trailingSwipeActions_ only with their respective handlers in the event of a delete.
Note here how we fetch the object to delete first from the _fetchResultsController_ and then pass it to our CoreData _viewContext_ to delete.

```swift
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, completionHandler) in            
            // 6a. Delete CoreData here
            let game = self.fetchedResultsController.object(at: indexPath)
            GameManager.shared.persistentContainer.viewContext.delete(game)
            GameManager.shared.saveContext()
        })
        action.image = makeSymbolImage(systemName: "trash")

        let configuration = UISwipeActionsConfiguration(actions: [action])

        return configuration
    }
```

Then update the table only after the _fetchResultsController_ calls us back. This is a three step process: willChangeContent, didChange, didChangeContent.

```swift
extension DemoFetchedResultsViewController: NSFetchedResultsControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates() // a
    }
          
    // 6b Update table via delegate callback here.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade) // b
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
     
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates() // c
    }
}
```

Full source.

```swift
//
//  DemoFetchedResultsViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-16.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit
import CoreData

class DemoFetchedResultsViewController: UIViewController {

    // Replacing array with CoreData
//    var games = ["Space Invaders",
//                "Dragon Slayer",
//                "Disks of Tron",
//                "Moon Patrol",
//                "Galaga"]

    // 1
    var fetchedResultsController: NSFetchedResultsController<Game>!
    
    let viewContext = GameManager.shared.persistentContainer.viewContext
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textAlignment = .center
        textField.backgroundColor = .systemFill

        return textField
    }()

    lazy var addButton: UIButton = {
        let button = makeButton(withText: "Add")
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(addButtonPressed), for: .primaryActionTriggered)

        return button
    }()

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    let cellId = "insertCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        loadSavedData()
        setupTableView()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    func layout() {
        navigationItem.title = "Fetched Results Demo"
        
        let addStackView = makeHorizontalStackView()
        addStackView.addArrangedSubview(textField)
        addStackView.addArrangedSubview(addButton)

        view.addSubview(addStackView)
        view.addSubview(tableView)

        addStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        addStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: addStackView.trailingAnchor, multiplier: 3).isActive = true

        tableView.topAnchor.constraint(equalToSystemSpacingBelow: addStackView.bottomAnchor, multiplier: 1).isActive = true
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 1).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1).isActive = true
    }

    // 3
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = NSFetchRequest<Game>(entityName: "Game")
            let sort = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20

            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }

        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }

    // MARK: - Actions

    @objc
    func addButtonPressed() {
        guard let name = textField.text else { return }

        // 4 CoreData viewContext > NSFetchRequest > Delegate (us)
        GameManager.shared.createGame(name: name)

//        games.append(text)
//
//        let indexPath = IndexPath(row: games.count - 1, section: 0)
//
//        tableView.beginUpdates()
//        tableView.insertRows(at: [indexPath], with: .fade)
//        tableView.endUpdates()
    }
}

// MARK:  - UITableView DataSource

extension DemoFetchedResultsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // 5
        // cell.textLabel?.text = games[indexPath.row]
        let game = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = game.name

        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, completionHandler) in
            // 6 Deletion is now a two step process.
//            self.games.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // 6a. Delete CoreData here
            let game = self.fetchedResultsController.object(at: indexPath)
            GameManager.shared.persistentContainer.viewContext.delete(game)
            GameManager.shared.saveContext()
        })
        action.image = makeSymbolImage(systemName: "trash")

        let configuration = UISwipeActionsConfiguration(actions: [action])

        return configuration
    }

    // 7
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

}

// 8
extension DemoFetchedResultsViewController: NSFetchedResultsControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates() // a
    }
          
    // 6b Update table via delegate callback here.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade) // b
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
     
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates() // c
    }
}

```


### Links that help

- [Apple Docs NSFetchResultsController](https://developer.apple.com/documentation/coredata/nsfetchedresultscontroller)
- [CoreData Programming with NSFetchResultsController](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/nsfetchedresultscontroller.html)
- [Hacking in Swift](https://www.hackingwithswift.com/read/38/10/optimizing-core-data-performance-using-nsfetchedresultscontroller)

### Video

- [Getting started with NSFetchResultsController](https://www.youtube.com/watch?v=-gJJS-EsdF4)

