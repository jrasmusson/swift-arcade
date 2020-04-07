//
//  Network.swift
//  DiffableTableView
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-06.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

struct Network: Hashable {
    let name: String
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Network, rhs: Network) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
