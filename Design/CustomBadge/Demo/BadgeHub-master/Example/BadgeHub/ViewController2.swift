//
//  ViewController2.swift
//  BadgeHub_Example
//
//  Created by jrasmusson on 2021-03-25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    private var hub: BadgeHub?
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: view.frame.size.width / 2 - 48,
                          y: 80, width: 96, height: 96)
        iv.image = UIImage(named: "github_color")
        return iv
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 16, y: 200, width: 130, height: 44)
        button.setTitle("Decrement (-1)", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: UIScreen.main.bounds.width - 16 - 130,
                              y: 200, width: 130, height: 44)
        button.setTitle("Increment (+1)", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupImageView()
    }
    
    private func setupButtons() {
        view.addSubview(incrementButton)
        view.addSubview(decrementButton)
        incrementButton.addTarget(self,
                                  action: #selector(self.testIncrement),
                                  for: .touchUpInside)
        decrementButton.addTarget(self,
                                  action: #selector(self.testDecrement),
                                  for: .touchUpInside)
    }
    
    private func setupImageView() {
        hub = BadgeHub(view: imageView)
        hub?.moveCircleBy(x: -15, y: 15)
        view.addSubview(imageView)
    }
    
    @objc private func testIncrement() {
        hub?.increment()
        hub?.pop()
//        hub?.bump()
    }
    
    @objc private func testDecrement() {
        hub?.decrement()
    }
}

