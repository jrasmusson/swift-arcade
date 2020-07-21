//
//  HistoryViewModel.swift
//  HistorySpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-21.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

struct HistoryViewModel {
    
    // UI friendly for display
    var sections = [HistorySection]()
    
    // Raw input to be converted
    var transactions: [Transaction]? {
        didSet {
            guard let txs = transactions else { return }
            
            // filter by month - hard coded
            let firstMonth = "Jul"
            let secondMonth = "Jun"
            let thirdMonth = "May"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            let firstMonthTransactions = txs.filter {
                let dateString = dateFormatter.string(from: $0.date)
                return dateString.starts(with: firstMonth)
            }
        
            // create section
            let firstMonthSection = HistorySection(title: "July", transactions: firstMonthTransactions)
            
            // append to array
            sections = [HistorySection]()
            sections.append(firstMonthSection)
        }
    }
}

//        let tx1 = Transaction(id: 1, type: "redeemed", amount: "1", date: Date())
//        let tx11 = Transaction(id: 1, type: "redeemed", amount: "11", date: Date())
//
//        let tx2 = Transaction(id: 1, type: "redeemed", amount: "2", date: Date())
//
//        let tx3 = Transaction(id: 1, type: "redeemed", amount: "3", date: Date())
//        let tx33 = Transaction(id: 1, type: "redeemed", amount: "33", date: Date())
//        let tx333 = Transaction(id: 1, type: "redeemed", amount: "333", date: Date())

//        let section1 = HistorySection(title: "July", transactions: [tx1, tx11])
//        let section2 = HistorySection(title: "June", transactions: [tx2])
//        let section3 = HistorySection(title: "May", transactions: [tx3, tx33, tx333])
//
//        viewModel = HistoryViewModel(sections: [section1, section2, section3])
