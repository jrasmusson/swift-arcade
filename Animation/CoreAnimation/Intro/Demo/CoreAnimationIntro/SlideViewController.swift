//
//  ViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-16.
//

import UIKit

class SlideViewController: UIViewController {
        
    let slideButton = makeButton(withText: "Slide barrel")
    
    lazy var donkeyView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 50, y: 160, width: 388, height: 203))
        view.image = UIImage(named: "donkey")
        
        return view
    }()

    lazy var marioView: UIImageView = {
        let ratio = 1.5
        let view = UIImageView(frame: CGRect(x: 800, y: 190, width: 119/ratio, height: 258/ratio))
        view.image = UIImage(named: "mario")
        
        return view
    }()

    lazy var barrelView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 500, y: 300, width: 100, height: 60))
        view.image = UIImage(named: "barrel")
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        animate()
    }
}

// MARK: - Setup

extension SlideViewController {
    func setup() {
        slideButton.addTarget(self, action: #selector(slideTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(donkeyView)
        view.addSubview(marioView)
        view.addSubview(barrelView)
        view.addSubview(slideButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            slideButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            slideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func slideTapped(_ sender: UIButton) {
        animate()
    }
}

// MARK: - Animations

extension SlideViewController {

    func animate() {
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 550
        animation.toValue = 700
        animation.duration = 1
        
        barrelView.layer.add(animation, forKey: "basic")
        
        // update model to reflect final position of presentation layer
        barrelView.layer.position = CGPoint(x: 700, y: 330)
        
//        let view = UIImageView(frame: CGRect(x: 500, y: 300, width: 100, height: 60))
    }
}

