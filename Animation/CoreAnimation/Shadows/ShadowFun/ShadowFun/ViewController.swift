//
//  ViewController.swift
//  ShadowFun
//
//  Created by jrasmusson on 2021-01-25.
//

import UIKit

class ViewController: UIViewController {

    let shadowView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowView.backgroundColor = .systemBlue
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(shadowView)
        
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shadowView.widthAnchor.constraint(equalToConstant: 300),
            shadowView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)

    }
}

