//
//  ViewController.swift
//  SubviewSpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    let childView = ChildView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }

    func setup() {
        childView.translatesAutoresizingMaskIntoConstraints = false
    }

    func layout() {
        view.addSubview(childView)
        
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
