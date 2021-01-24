//
//  ClippedViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-24.
//

import UIKit

class ClippedViewController: UIViewController {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "flowers")
        
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // Normally we could ...
        // imageView.layer.shadowOpacity = 0.5
        // imageView.layer.shadowOffset = CGSize(width: 5, height: 5)

        // But when clipped..
        imageView.clipsToBounds = true
    }
    
    // We can fix by...
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let shadowPath = UIBezierPath(rect: imageView.bounds)
        imageView.layer.masksToBounds = false // adding this line here
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowPath = shadowPath.cgPath
    }
}
