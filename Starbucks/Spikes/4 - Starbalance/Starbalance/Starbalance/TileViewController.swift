//
//  TileViewController.swift
//  Starbalance
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-01.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class TileViewController: UIViewController {
    
    let tileView = TileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        tileView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(tileView)
        
        NSLayoutConstraint.activate([
            tileView.topAnchor.constraint(equalTo: view.topAnchor),
            tileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
