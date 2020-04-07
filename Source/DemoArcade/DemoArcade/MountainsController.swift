//
//  MountainsController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-07.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

/*
Abstract:
 Controller object that manages our Mountain values and allows for searches
*/

class MountainsController {

    struct Mountain: Hashable {
        
        let name: String
        let height: Int
        let identifier = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs: Mountain, rhs: Mountain) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func contains(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return name.lowercased().contains(lowercasedFilter)
        }
    }
    
    func filteredMountains(with filter: String?=nil, limit: Int?=nil) -> [Mountain] {
        let filtered = mountains.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }
    
    private lazy var mountains: [Mountain] = {
        return generateMountains()
    }()
}

extension MountainsController {
    private func generateMountains() -> [Mountain] {
        let components = mountainsRawData.components(separatedBy: CharacterSet.newlines)
        var mountains = [Mountain]()
        
        for line in components {
            let mountainComponents = line.components(separatedBy: ",")
            let name = mountainComponents[0]
            let height = Int(mountainComponents[1])
            mountains.append(Mountain(name: name, height: height!))
        }
        return mountains
    }
}
