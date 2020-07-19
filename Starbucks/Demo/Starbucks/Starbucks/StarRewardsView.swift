//
//  StarRewards.swift
//  Starbalance
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-30.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class StarRewardsView: UIView {
    
    let stackView = UIStackView()
    let label = UILabel()
    
    struct Reward {
        let numberOfPoints: String
        let description: String
    }

    var rewards: [Reward] =
        [Reward(numberOfPoints: "25", description: "Customize your drink"),
         Reward(numberOfPoints: "50", description: "Brewed hot coffee, bakery item or hot tea"),
         Reward(numberOfPoints: "150", description: "Handcrafted drink, hot breakfast or parfait"),
         Reward(numberOfPoints: "250", description: "Lunch sandwich or protein box"),
         Reward(numberOfPoints: "400", description: "Select merchandise or at-home coffee"),
    ]
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarRewardsView {
    
    func style() {
        backgroundColor = .tileBrown
        layer.cornerRadius = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 26
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: -16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        label.text = "Rewards you can get with Stars"
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        
        for reward in rewards {
            stackView.addArrangedSubview(StarRewardsRow(numberOfPoints: reward.numberOfPoints, description: reward.description))
        }
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
