//
//  SectionHeaderView.swift
//  SectionHeader
//
//  Created by jrasmusson on 2021-08-24.
//

import Foundation
import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet var titleLabel: UILabel!
    
    static let reuseIdentifier = "SectionHeaderView"
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // configure here if values need to be dynamic or override
    }
}
