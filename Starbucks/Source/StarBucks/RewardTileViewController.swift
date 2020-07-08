//
//  RewardsTileViewController.swift
//  Starbalance
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class RewardsTileViewController: UIViewController {
    
    let rewardsTileView = RewardsTileView()
    
    /*
     Both these techniques work for layout out subviews.
     The first fills the entire frame with the view passed in.
     The second uses autolayout.
     
     First is OK if View Controller is a tile never touching safe areas.
     Second is better if ViewController touches top or bottom of screen.
     */
        
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view = rewardsTileView
//    }
    
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
