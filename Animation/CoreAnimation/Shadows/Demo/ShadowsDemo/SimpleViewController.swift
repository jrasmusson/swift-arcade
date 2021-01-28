//
//  SimpleShadowViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-23.
//

import UIKit

class SimpleViewController: UIViewController {
    
    let sv = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simple Shadow"
        sv.backgroundColor = .systemBlue
        
        sv.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(sv)
        
        NSLayoutConstraint.activate([
            sv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sv.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sv.widthAnchor.constraint(equalToConstant: 300),
            sv.heightAnchor.constraint(equalToConstant: 200),
        ])

        sv.layer.shadowOpacity = 0.5
        sv.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}

