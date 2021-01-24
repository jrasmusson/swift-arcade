//
//  ShadowViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-23.
//

import UIKit

class TestViewController: UIViewController {
    
    let vw = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Test"
        vw.backgroundColor = .systemRed
        
        vw.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(vw)
        
        NSLayoutConstraint.activate([
            vw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vw.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vw.widthAnchor.constraint(equalToConstant: 300),
            vw.heightAnchor.constraint(equalToConstant: 200),
        ])

//        vw.layer.shadowOpacity = 0.5

        
//        vw.layer.shadowColor = UIColor(white: 0.5, alpha: 1).cgColor
//        vw.layer.shadowRadius = 5.0
//        vw.layer.shadowPath = CGPath.init(rect: CGRect.init(x: 0, y: 0, width: 50, height: 50), transform: nil)
        vw.layer.shadowOpacity = 0.5
        vw.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
}
