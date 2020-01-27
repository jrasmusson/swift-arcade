//
//  UIViewControllerDemo.swift
//  SwiftArcadeDemos
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ModalNavigation: UIViewController {
    
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
        navigationItem.title = "Modal"
        
        view.addSubview(presentButton)
        
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc func presentPressed() {
        // presents a viewController modally
        let viewController = PresentViewController1()
        present(viewController, animated: true, completion: nil)
    }
    
}
