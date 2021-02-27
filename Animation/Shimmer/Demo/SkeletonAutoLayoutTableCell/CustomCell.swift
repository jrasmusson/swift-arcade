//
//  CustomCell.swift
//  SkeletonAutoLayoutTableCell
//
//  Created by jrasmusson on 2021-02-24.
//

import UIKit

class CustomCell: UITableViewCell {

    let titleLabel = UILabel()
    let yearLabel = UILabel()
    
    var game: Game? {
        didSet {
            guard let game = game else { return }
            titleLabel.text = game.title
            yearLabel.text = game.year
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell {

    func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(yearLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            yearLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: yearLabel.trailingAnchor, multiplier: 2),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        yearLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}
