//
//  LoadingViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        view.backgroundColor = .systemYellow

        let label = makeLabel(withTitle: "Loading...")

        view.addSubview(label)

        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
