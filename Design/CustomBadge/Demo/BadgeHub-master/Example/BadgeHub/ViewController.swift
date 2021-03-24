//
//  ViewController.swift
//  BadgeHub
//
//  Created by Jogendra on 05/31/2019.
//  Copyright (c) 2019 Jogendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var hub: BadgeHub?
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: view.frame.size.width / 2 - 48,
                          y: 80, width: 96, height: 96)
        iv.image = UIImage(named: "github_color")
        return iv
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
    }
    
    private func setupImageView() {
        hub = BadgeHub(view: imageView)
        hub?.setCount(200)
        view.addSubview(imageView)
    }
}
