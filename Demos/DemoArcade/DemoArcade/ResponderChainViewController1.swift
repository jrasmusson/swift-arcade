//
//  ResponderViewController1.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ResponderChainViewController1: UIViewController {

    let continueButton: UIButton = {
        let button = makeButton(withText: "Continue")
        button.addTarget(self, action: #selector(continuePressed), for: .primaryActionTriggered)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .systemGreen
        navigationItem.title = "Responder1"

        view.addSubview(continueButton)

        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Actions

    @objc func continuePressed() {
        if let navigationController = navigationController {
            let viewController = ResponderChainViewController2()
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
