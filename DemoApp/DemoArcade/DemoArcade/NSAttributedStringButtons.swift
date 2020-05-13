//
//  NSAttributedStringButton.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class NSAttributedStringButtons: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "Button"
        
        let stackView = makeVerticalStackView()
        stackView.addArrangedSubview(makeSpotifyButton(withText: "PLAY ON SPOTIFY"))
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 8).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 8).isActive = true
    }
    
}
