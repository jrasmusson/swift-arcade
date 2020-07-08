//
//  ParentViewController.swift
//  SubviewSpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation
import UIKit

class ParentViewController: UIViewController {
    
    let childVC = ChildViewController()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(childVC)
        scrollView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    func layout() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            // x2 sets of constraints
            childVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
