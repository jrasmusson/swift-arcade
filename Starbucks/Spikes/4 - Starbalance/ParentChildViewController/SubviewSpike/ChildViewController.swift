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
        // x3 ways to extract view
        
        // 1. Auto layout (Recommended).
        let childView = ChildView()
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childView)
        
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 2. Auto resize masks (Older style).
        let childView = ChildView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        childView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(childView)
        
        // 3. Full View take over.
        let childView = ChildView()
        view = childView
    }
}
