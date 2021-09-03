//
//  SectionsViewController.swift
//  SimpleInsert
//
//  Created by jrasmusson on 2021-09-03.
//

import UIKit

struct Transaction {
    let amount: String
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
        let newTx1 = Transaction(amount: "$800")
        
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
        let tx1 = Transaction(amount: "$100")
        let tx2 = Transaction(amount: "$200")
        let tx3 = Transaction(amount: "$300")

        let tx4 = Transaction(amount: "$400")
        let tx5 = Transaction(amount: "$500")
        let tx6 = Transaction(amount: "$600")
        let tx7 = Transaction(amount: "$700")
        
        let section1 = Section(title: "Pending transfers", transactions: [tx1, tx2, tx3])
        let section2 = Section(title: "Posted transfers", transactions: [tx4, tx5, tx6, tx7])

        viewModel = TransactionViewModel(sections: [section1, section2])
    }
}
