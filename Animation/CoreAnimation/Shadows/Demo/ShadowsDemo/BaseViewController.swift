//
//  BaseViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-24.
//

import UIKit

class BaseViewController: UIViewController {
    
    let sv = UIView() // shadowView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Base Shadow"
        
        sv.backgroundColor = .systemGreen
        sv.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(sv)
        
        NSLayoutConstraint.activate([
            sv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sv.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sv.widthAnchor.constraint(equalToConstant: 300),
            sv.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

