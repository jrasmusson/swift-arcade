//
//  RoundedCornersViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-23.
//

import UIKit

class RoundedCornersViewController: UIViewController {
    
    let roundedView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = .systemBlue
        
        view.addSubview(roundedView)
        title = "Rounded Corners"
        
        roundedView.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            roundedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundedView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            roundedView.widthAnchor.constraint(equalToConstant: 300),
            roundedView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
