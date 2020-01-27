//
//  ContainerViewController1.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-27.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ContainerViewController1: UIViewController {
    
    let pushButton: UIButton = {
        let button = makeButton(withText: "Push another")
        button.addTarget(self, action: #selector(pushPressed), for: .primaryActionTriggered)
        return button
    }()
    
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
        view.backgroundColor = .systemGreen
        navigationItem.title = "ContainerViewConroller1"
        
        view.addSubview(pushButton)
        view.addSubview(popButton)
        
        pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pushButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        popButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popButton.topAnchor.constraint(equalToSystemSpacingBelow: pushButton.bottomAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: - Actions

    @objc func pushPressed() {
        if let navigationController = navigationController {
            let viewController = ContainerViewController2()
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func popPressed() {
        dismiss(animated: true, completion: nil) // dismiss entire navigation stack
    }
}

