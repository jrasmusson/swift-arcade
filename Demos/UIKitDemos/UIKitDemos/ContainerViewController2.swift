//
//  ContainerViewController2.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-27.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ContainerViewController2: UIViewController {

    let popButton: UIButton = {
        let button = makeButton(withText: "Pop")
        button.addTarget(self, action: #selector(popPressed), for: .primaryActionTriggered)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "ContainerViewController2"

        view.addSubview(popButton)

        popButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Actions

    @objc func popPressed() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
