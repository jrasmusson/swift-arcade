//
//  RetryViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

@objc protocol FailableView: class {
    func retry(sender: Any?)
}

class RetryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        view.backgroundColor = .systemRed
        let button = makeButton(withText: "Retry")
        button.addTarget(nil, action: #selector(FailableView.retry(sender:)), for: .primaryActionTriggered)

        view.addSubview(button)

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

