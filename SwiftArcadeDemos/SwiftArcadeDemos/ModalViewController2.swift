//
//  PresentViewController2.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ModalViewController2: UIViewController {
    
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
        view.backgroundColor = .systemBlue
        navigationItem.title = "PressentViewController2"
        
        view.addSubview(dismissButton)
        
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Actions
    @objc func dismissPressed() {
        // dimiss the viewController presented modally
        dismiss(animated: true, completion: nil)
    }
    
}
