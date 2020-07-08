//
//  ViewController.swift
//  Graph
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let rewardsGraphView = RewardsGraphView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        rewardsGraphView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rewardsGraphView)
        
        NSLayoutConstraint.activate([
            rewardsGraphView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rewardsGraphView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rewardsGraphView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])  
    }

}
