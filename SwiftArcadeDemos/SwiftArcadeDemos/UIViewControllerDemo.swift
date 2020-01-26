//
//  UIViewControllerDemo.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class UIViewControllerDemo: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .systemRed
        navigationItem.title = "UIViewController"
    }
}
