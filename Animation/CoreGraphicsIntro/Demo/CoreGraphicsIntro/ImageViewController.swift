//
//  CGRectViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

class ImageViewController: UIViewController {
    
    // can hard code the postion exactly via a CGRect
    lazy var shipView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 1024/4, y: 1366/2, width: 75, height: 90))
        view.image = UIImage(named: "ship")

        return view
    }()

    // or can load and layout via auto layout
    lazy var worldView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "world"))

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "How to load images"
        
        view.addSubview(worldView)
        view.addSubview(shipView)
        
        worldView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            worldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            worldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
