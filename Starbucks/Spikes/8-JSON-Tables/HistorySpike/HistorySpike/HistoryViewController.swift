//
//  ViewController.swift
//  HistorySpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-20.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

struct Transaction: Codable {
    let id: Int
    let type: String
    let amount: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case date = "processed_at"
    }
}

struct HistorySection {
    let title: String
    let transactions: [Transaction]
}

struct HistoryViewModel {
    let sections: [HistorySection]
}

class HistoryViewController: UITableViewController {
    
    let cellId = "cellId"
    var viewModel: HistoryViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        data()
        style()
    }
    
    func data() {
        let tx1 = Transaction(id: 1, type: "redeemed", amount: "1", date: Date())
        let tx11 = Transaction(id: 1, type: "redeemed", amount: "11", date: Date())

        let tx2 = Transaction(id: 1, type: "redeemed", amount: "2", date: Date())

        let tx3 = Transaction(id: 1, type: "redeemed", amount: "3", date: Date())
        let tx33 = Transaction(id: 1, type: "redeemed", amount: "33", date: Date())
        let tx333 = Transaction(id: 1, type: "redeemed", amount: "333", date: Date())
        
        let section1 = HistorySection(title: "July", transactions: [tx1, tx11])
        let section2 = HistorySection(title: "June", transactions: [tx2])
        let section3 = HistorySection(title: "May", transactions: [tx3, tx33, tx333])
        
        viewModel = HistoryViewModel(sections: [section1, section2, section3])
    }
    
    func style() {
        navigationItem.title = "History"
        tableView.register(HistoryViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: Data Source

extension HistoryViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HistoryViewCell else {
            return UITableViewCell()
        }
        
        let section = indexPath.section
        
        // limit of x3
        var transaction: Transaction
        switch section {
        case 0:
            transaction = vm.sections[0].transactions[indexPath.row]
        case 1:
            transaction = vm.sections[1].transactions[indexPath.row]
        case 2:
            transaction = vm.sections[2].transactions[indexPath.row]
        default:
            return UITableViewCell()
        }

        cell.transaction = transaction
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
    
        switch section {
        case 0:
            return vm.sections[0].transactions.count
        case 1:
            return vm.sections[1].transactions.count
        case 2:
            return vm.sections[2].transactions.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let vm = viewModel else { return nil }
        
        switch section {
        case 0:
            return vm.sections[0].title
        case 1:
            return vm.sections[1].title
        case 2:
            return vm.sections[2].title
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewModel?.sections else { return 0 }
        return sections.count
    }
}
