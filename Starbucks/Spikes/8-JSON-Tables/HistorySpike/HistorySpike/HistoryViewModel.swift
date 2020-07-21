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
    let sections: [HistorySection]
    
    // Raw input to be converted
    var transactions: [Transaction]? {
        didSet {
            // filter by month
            // create txs by month
            // create section
            // append to array
        }
    }
}

