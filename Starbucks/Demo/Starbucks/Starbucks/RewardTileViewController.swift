//
//  RewardsTileViewController.swift
//  Starbucks
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-14.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class RewardTileViewController: UIViewController {
    
    let rewardsTileView = RewardTileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        rewardsTileView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rewardsTileView)
        
        NSLayoutConstraint.activate([
            rewardsTileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rewardsTileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rewardsTileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rewardsTileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
