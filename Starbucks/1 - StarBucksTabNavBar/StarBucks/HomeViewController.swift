//
//  HomeViewController.swift
//  StarBucks
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-23.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class HomeViewController: StarBucksViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "house.fill", title: "Home")
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.topItem?.title = "Good afternoon, Jonathan ☀️"
    }


}

