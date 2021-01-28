//
//  MoveViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-27.
//

import UIKit

/*
 This is how we can animate a view to a new position.
 We specify the inital position of the view. Then we animate the center of the view
 (it's position) to a new position using Core Animation.
 
 Then because Core Animation tracks its animations in a separate layer, we need to
 updat the final position of the view to the final position of the view in
 the animation.
 */

class MoveViewController: UIViewController {

    let redView = UIView(frame: CGRect(x: 20, y: 100, width: 140, height: 100))
    let button = makeButton(withText: "Animate")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.backgroundColor = .systemRed
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(redView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func animate() {
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 20 + 140/2
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.position = CGPoint(x: 300, y: 100 + 100/2) // update to final position
    }

    @objc func buttonTapped(_ sender: UIButton) {
        animate()
    }
}


// MARK: - Factories

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}

