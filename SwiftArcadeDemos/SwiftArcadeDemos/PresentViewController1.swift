//
//  PresentViewController1.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class PresentViewController1: UIViewController {
    
    let presentButton: UIButton = {
        let button = makeButton(withText: "Present")
        button.addTarget(self, action: #selector(presentPressed), for: .primaryActionTriggered)
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = makeButton(withText: "Dismiss")
        button.addTarget(self, action: #selector(dismissPressed), for: .primaryActionTriggered)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .systemGreen
        navigationItem.title = "PressentViewController1"
        
        view.addSubview(presentButton)
        view.addSubview(dismissButton)
        
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalToSystemSpacingBelow: presentButton.bottomAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: - Actions

    @objc func presentPressed() {
        // presents a viewController modally
        let viewController = PresentViewController2()
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func dismissPressed() {
        // dimiss the viewController presented modally
        dismiss(animated: true, completion: nil)
    }
}
