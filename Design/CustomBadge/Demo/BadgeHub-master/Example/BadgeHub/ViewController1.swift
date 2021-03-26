//
//  ViewController1.swift
//  BadgeHub_Example
//
//  Created by jrasmusson on 2021-03-26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    let label = UILabel()
    let button = UIButton()
    
    let diameter: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = diameter / 2
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.textColor = .white
        label.clipsToBounds = true
        label.text = "99" // Good for 2 digits
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        button.layer.cornerRadius = diameter / 2
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitle("4444", for: .normal)
        
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: diameter),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: diameter),

            button.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 2),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: diameter),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: diameter),
        ])
    }
}

