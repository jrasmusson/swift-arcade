//
//  ScaleViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-28.
//

import UIKit

class ScaleViewController: UIViewController {

    let redView = UIView()
    let _width: CGFloat = 140
    let _height: CGFloat = 100
    
    let button = makeButton(withText: "Animate")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.backgroundColor = .systemRed
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(redView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 2),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)
    }
    
    func animate() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.4
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeScale(2, 2, 1) // update
    }

    @objc func buttonTapped(_ sender: UIButton) {
        animate()
    }
}
