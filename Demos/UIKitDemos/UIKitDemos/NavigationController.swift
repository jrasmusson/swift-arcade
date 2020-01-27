//
//  ContainerNavigation.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-27.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class NavigationController: UIViewController {

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
        navigationItem.title = "NavigationController Container"

        view.addSubview(presentButton)

        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Actions

    @objc func presentPressed() {
        // Present container navigation controller
        let navController = UINavigationController()
        navController.pushViewController(NavigationViewController1(), animated: true)

        // Modally (default)
        present(navController, animated: true, completion: nil)

        // Full screen take over
//        navController.modalPresentationStyle = .fullScreen
//        present(navController, animated: true, completion: nil)
    }

}
