//
//  StarRewardsRow.swift
//  Starbalance
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-30.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class StarRewardsRow: UIView {
        
    let starAndPoints = StarAndPoints()
    let descriptionLabel = UILabel()
        
    init(numberOfPoints: String, description: String) {
        starAndPoints.pointsLabel.text = numberOfPoints
        descriptionLabel.text = description
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarRewardsRow {
    func style() {
        starAndPoints.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.sizeToFit()
    }
    
    func layout() {
        addSubview(starAndPoints)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            starAndPoints.topAnchor.constraint(equalTo: topAnchor),
            starAndPoints.bottomAnchor.constraint(equalTo: bottomAnchor),
            starAndPoints.leadingAnchor.constraint(equalTo: leadingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: starAndPoints.trailingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        starAndPoints.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabel.frame.size.height).setActiveBreakable()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 16)
    }
}
