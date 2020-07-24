//
//  ViewController.swift
//  1-AddTable
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-23.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

///
struct HistorySection2 {
    let title: String
    let transactions: [Transaction]
}

struct Transaction2: Codable {
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
///

class HistoryViewController2: UITableViewController {
    
    var sections = [HistorySection]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        data()
    }
    
    func style() {
        navigationItem.title = "History"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    ///
    func data() {
        let tx1 = Transaction(id: 1, type: "redeemable", amount: "1", date: Date())
        let tx2 = Transaction(id: 1, type: "redeemable", amount: "2", date: Date())
        let tx22 = Transaction(id: 1, type: "redeemable", amount: "22", date: Date())
        let tx3 = Transaction(id: 1, type: "redeemable", amount: "3", date: Date())
        let tx33 = Transaction(id: 1, type: "redeemable", amount: "33", date: Date())
        let tx333 = Transaction(id: 1, type: "redeemable", amount: "333", date: Date())
        
        let firstSection = HistorySection(title: "July", transactions: [tx1])
        let secondSection = HistorySection(title: "June", transactions: [tx2, tx22])
        let thirdSection = HistorySection(title: "May", transactions: [tx3, tx33, tx333])
        
        sections.append(firstSection)
        sections.append(secondSection)
        sections.append(thirdSection)
    }
    ///
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        ///
        let section = indexPath.section
        
        var transaction: Transaction
        switch section {
        case 0:
            transaction = sections[0].transactions[indexPath.row]
        case 1:
            transaction = sections[1].transactions[indexPath.row]
        case 2:
            transaction = sections[2].transactions[indexPath.row]
        default:
            return UITableViewCell()
        }

        cell.textLabel?.text = transaction.amount
        ///
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ///
        switch section {
        case 0:
            return sections[0].transactions.count
        case 1:
            return sections[1].transactions.count
        case 2:
            return sections[2].transactions.count
        default:
            return 0
        }
        ///
    }
    
    ///
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return sections[0].title
        case 1:
            return sections[1].title
        case 2:
            return sections[2].title
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
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .tileBrown
    }
    ///
}
