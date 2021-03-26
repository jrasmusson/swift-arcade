//
//  ViewController2.swift
//  BadgeHub_Example
//
//  Created by jrasmusson on 2021-03-26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol Badgeable {}

extension UIView: Badgeable {
    func addBadge() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let diameter: CGFloat = 30
        let badge = UIButton()

        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.contentEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        badge.layer.cornerRadius = diameter / 2
        badge.setTitleColor(.white, for: .normal)
        badge.backgroundColor = .systemBlue
        badge.setTitle("4", for: .normal)

        addSubview(badge)

        NSLayoutConstraint.activate([
            badge.heightAnchor.constraint(equalToConstant: diameter),
            badge.widthAnchor.constraint(greaterThanOrEqualToConstant: diameter),
            badge.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            badge.bottomAnchor.constraint(equalTo: topAnchor, constant: 16),
        ])
    }
}

class ViewController2: UIViewController {
    
    let imageView = UIImageView()
    let diameter: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "github_color")
        imageView.addBadge()
        
        view.addSubview(imageView)
        imageView.addBadge()
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

