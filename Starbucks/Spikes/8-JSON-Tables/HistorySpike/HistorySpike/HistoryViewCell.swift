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
    let titleLabel = UILabel()
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
            guard let tx = transaction else { return }
            titleLabel.text = "\(tx.amount) Stars \(tx.type)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            dateLabel.text = dateFormatter.string(from: Date())
        }
    }
}

extension HistoryViewCell {
            
    func config() {
        backgroundColor = .tileBrown
        selectionStyle = .none
        
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.tintColor = .starYellow
        starView.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(starView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            starView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            starView.heightAnchor.constraint(equalToConstant: 36),
            starView.widthAnchor.constraint(equalToConstant: 36),
            starView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: starView.trailingAnchor, multiplier: 2),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: dateLabel.trailingAnchor, multiplier: 4),
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

