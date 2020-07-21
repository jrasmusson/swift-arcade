//
//  HistoryViewCell.swift
//  HistorySpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-21.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class HistoryViewCell: UITableViewCell {
    
    let starView = makeSymbolImageView(systemName: "star")
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var transaction: Transaction? {
        didSet {
            
        }
    }
}

extension HistoryViewCell {
            
    func config() {
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.tintColor = .starYellow
        starView.contentMode = .scaleAspectFit
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(starView)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            starView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            starView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
}

