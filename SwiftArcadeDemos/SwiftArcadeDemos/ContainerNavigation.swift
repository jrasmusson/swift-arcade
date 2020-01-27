//
//  ContainerNavigation.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-27.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ContainerNavigation: UIViewController {
    
    let pushButton: UIButton = {
        let button = makeButton(withText: "Push")
        button.addTarget(self, action: #selector(pushPressed), for: .primaryActionTriggered)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Container"
        
        view.addSubview(pushButton)
        
        pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pushButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc func pushPressed() {
        // present a viewController with in a container
        let navController = UINavigationController()
        navController.pushViewController(ContainerViewController1(), animated: true)
        
        present(navController, animated: true, completion: nil)
    }
    
}
