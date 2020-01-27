//
//  ContainerNavigation.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-27.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ContainerNavigation: UIViewController {

    let presentButton: UIButton = {
        let button = makeButton(withText: "Present")
        button.addTarget(self, action: #selector(presentPressed), for: .primaryActionTriggered)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Container"

        view.addSubview(presentButton)

        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Actions

    @objc func presentPressed() {
        // present a container navigation controller
        let navController = UINavigationController()
        navController.pushViewController(ContainerViewController1(), animated: true)

        present(navController, animated: true, completion: nil) // present modally
        
    }

}
