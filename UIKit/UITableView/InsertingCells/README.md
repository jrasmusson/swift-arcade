# Inserting Cells

## Single Row


New cells can be animated in by:

- adding them to your data source
- calculating the index paths required
- wrapping `insertRows` in begin and end updates


```swift
@objc func addTapped(_ sender: UIBarButtonItem) {
    games.append("Tron")

    let indexPath = IndexPath(row: games.count - 1, section: 0)

    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath], with: .fade)
    tableView.endUpdates()
}
```

### Example

```swift
import UIKit

class ViewController: UIViewController {

    var data = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]

    lazy var addBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigationBar()
    }

    @objc func addTapped(_ sender: UIBarButtonItem) {
        data.append("Tron")

        let indexPath = IndexPath(row: games.count - 1, section: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

// MARK: Setup
extension ViewController {
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }

    private func setupNavigationBar() {
        title = "Games"
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}
```

## Multiple Rows Batch

If you try inserting more than one row as using the technique above

```swift
@objc func addTapped(_ sender: UIBarButtonItem) {
    games.append("Tron")
    games.append("Dig Dug")
    games.append("Moon Patrol")

    let indexPath = IndexPath(row: data.count - 1, section: 0)

    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath], with: .fade)
    tableView.endUpdates()
}
```

You will get an error:

```
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', 
reason: 'Invalid update: invalid number of rows in section 0. The number of rows 
contained in an existing section after the update (6) must be equal to the number of 
rows contained in that section before the update (3), plus or minus the number of 
rows inserted or deleted from that section (1 inserted, 0 deleted) and plus or minus 
the number of rows moved into or out of that section (0 moved in, 0 moved out).'
```

What this is saying is you added `3` rows, but only inserted `1` new index.

To fix you need to calculate an index for each new addition.

```swift
@objc func addTapped(_ sender: UIBarButtonItem) {
    data.append("Tron")
    data.append("Defender")
    data.append("Joust")

    // Create corresponding indexes
    let indexPath1 = IndexPath(row: data.count - 1, section: 0)
    let indexPath2 = IndexPath(row: data.count - 2, section: 0)
    let indexPath3 = IndexPath(row: data.count - 3, section: 0)

    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath1, indexPath2, indexPath3], with: .fade)
    tableView.endUpdates()
}
```

![](images/0.png)

### Example

```swift
import UIKit

class ViewController: UIViewController {

    var data = [
        "Pacman",
        "Frogger",
        "Galaga",
    ]

    lazy var addBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigationBar()
    }

    @objc func addTapped(_ sender: UIBarButtonItem) {
        data.append("Tron")
        data.append("Defender")
        data.append("Joust")

        let indexPath1 = IndexPath(row: data.count - 1, section: 0) // Tron
        let indexPath2 = IndexPath(row: data.count - 2, section: 0) // Defender
        let indexPath3 = IndexPath(row: data.count - 3, section: 0) // Joust


        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath1, indexPath2, indexPath3], with: .fade)
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

// MARK: Setup
extension ViewController {
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }

    private func setupNavigationBar() {
        title = "Games"
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}
```

## Sections

The same can be done with sections. You just need to:

- uses classes to keep references to sections and rows
- add your new data to the appropriate section
- set the row and section in the update

Here is how we would append a new row to the second section in our table.

```swift
@objc func addTapped(_ sender: UIBarButtonItem) {
    // Create new data row
    let newTx1 = Transaction(amount: "$800", type: .posted)
    
    // Get its section
    let section2 = viewModel?.sections[1]

    // Append row to section
    section2?.transactions.append(newTx1)
    
    // Calculate index path
    let count = section2!.transactions.count
    let indexPath = IndexPath(row: count - 1, section: 1)
    
    // Insert
    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath], with: .fade)
    tableView.endUpdates()
}
```

### Example

```swift
//
//  SectionsViewController.swift
//  SimpleInsert
//
//  Created by jrasmusson on 2021-09-03.
//

import UIKit

enum TransactionType: String {
    case pending = "Pending"
    case posted = "Posted"
}

struct Transaction {
    let amount: String
    let type: TransactionType
}

class Section {
    let title: String
    var transactions: [Transaction]
    
    init(title: String, transactions: [Transaction]) {
        self.title = title
        self.transactions = transactions
    }
}

class TransactionViewModel {
    let sections: [Section]
    
    init(sections: [Section]) {
        self.sections = sections
    }
}

class SectionsViewController: UIViewController {
    
    var viewModel: TransactionViewModel?
    var tableView = UITableView()
    let cellId = "cellId"
    
    lazy var addBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        fetchData()
    }
    
    @objc func addTapped(_ sender: UIBarButtonItem) {
        // Create new data row
        let newTx1 = Transaction(amount: "$800", type: .posted)
        
        // Get its section
        let section2 = viewModel?.sections[1]

        // Append row to section
        section2?.transactions.append(newTx1)
        
        // Calculate index path
        let count = section2!.transactions.count
        let indexPath = IndexPath(row: count - 1, section: 1)
        
        // Insert
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

// MARK: - Setup
extension SectionsViewController {
    func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view = tableView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupNavigationBar() {
        title = "Transfers"
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - UITableViewDataSource
extension SectionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let section = indexPath.section
        
        let text = vm.sections[section].transactions[indexPath.row].amount
        cell.textLabel?.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.sections[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let vm = viewModel else { return nil }
        return vm.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewModel?.sections else { return 0 }
        return sections.count
    }
}

// MARK: - Networking
extension SectionsViewController {
    private func fetchData() {
        let tx1 = Transaction(amount: "$100", type: .pending)
        let tx2 = Transaction(amount: "$200", type: .pending)
        let tx3 = Transaction(amount: "$300", type: .pending)

        let tx4 = Transaction(amount: "$400", type: .posted)
        let tx5 = Transaction(amount: "$500", type: .posted)
        let tx6 = Transaction(amount: "$600", type: .posted)
        let tx7 = Transaction(amount: "$700", type: .posted)
        
        let section1 = Section(title: "Pending transfers", transactions: [tx1, tx2, tx3])
        let section2 = Section(title: "Posted transfers", transactions: [tx4, tx5, tx6, tx7])

        viewModel = TransactionViewModel(sections: [section1, section2])
    }
}
```

## Append new data

A simpler technique is to simply add the new data to the existing data and then `reload` the entire table.

You don't get the cool animation of new rows being added, but it maintains your scroll position and simply adds the new data to the bottom.

```swift
class AppendViewController: UIViewController {

    var data = [
        "Pacman",
        "Frogger",
        "Galaga",
    ]

    var newData = [
        "Tron",
        "Defender",
        "Joust",
    ]

    @objc func addTapped(_ sender: UIBarButtonItem) {
        data.append(contentsOf: newData)
        tableView.reloadData()
    }
}
```

### Example

```swift
/*
 With this technique we don't worry about index paths.
 Instead we continuously append new data rows to our existing data
 and then simply re-render the entire table.

 This is much simpler and it maintains the scroll position of where you are.
 The only thing you lose is the animation of the new rows being added.
 */
import UIKit

class AppendViewController: UIViewController {

    var data = [
        "Pacman",
        "Frogger",
        "Galaga",
    ]

    var newData = [
        "Tron",
        "Defender",
        "Joust",
    ]

    lazy var addBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigationBar()
    }

    @objc func addTapped(_ sender: UIBarButtonItem) {
        data.append(contentsOf: newData)
        tableView.reloadData()
    }
}

extension AppendViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = data[indexPath.row]
        print("Game: \(game) indexPath: \(indexPath.row)")
    }
}

// MARK: Setup
extension AppendViewController {
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }

    private func setupNavigationBar() {
        title = "Games"
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}
```

### Links that help

- [Apple - Batch Insertion, Deletion, and Reloading of Rows and Sections](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/ManageInsertDeleteRow/ManageInsertDeleteRow.html#//apple_ref/doc/uid/TP40007451-CH10-SW9)