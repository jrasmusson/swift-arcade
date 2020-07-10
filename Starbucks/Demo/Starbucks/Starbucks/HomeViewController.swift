//
//  ViewController.swift
//  Starbucks
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-08.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class HomeViewController: StarBucksViewController {

    let headerView = HomeHeaderView()
    var headerViewTopConstraint: NSLayoutConstraint?
    
    let tiles = [
                "Star balance",
                "Bonus stars",
                "Try these",
                "Welcome back",
                "Uplifting"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setTabBarImage(imageName: "house.fill", title: "Home")
        
        style()
        layout()
    }

    func setupNavBar() {
        navigationController?.navigationBar.topItem?.title = "Good afternoon, Jonathan ☀️"
    }
}

extension HomeViewController {
    func style() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemPink
    }
    
    func layout() {
        view.addSubview(headerView)
        
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        NSLayoutConstraint.activate([
            headerViewTopConstraint!,
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}



// MARK: Animating scrollView

        
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y = scrollView.contentOffset.y
//
//        let swipingDown = y <= 0
//        let shouldSnap = y > 30
//        let labelHeight = headerView.greeting.frame.height + 16 // label + spacer (102)
//
//        UIView.animate(withDuration: 0.3) {
//            self.headerView.greeting.alpha = swipingDown ? 1.0 : 0.0
//        }
//
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
//            self.headerViewTopConstraint?.constant = shouldSnap ? -labelHeight : 0
//            self.view.layoutIfNeeded()
//        })
//    }

