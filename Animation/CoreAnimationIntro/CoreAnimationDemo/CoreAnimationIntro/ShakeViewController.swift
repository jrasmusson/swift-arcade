//
//  ShakeViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-17.
//

import UIKit

class ShakeViewController: UIViewController {
    
    let loginView = UITextField()
    let shakeButton = makeButton(withText: "Shake")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        animate()
    }
}

// MARK: - Setup

extension ShakeViewController {
    
    func setup() {
        let lockImageView = UIImageView(image: UIImage(systemName: "lock"))
        loginView.leftViewMode = .always
        loginView.leftView = lockImageView

        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.backgroundColor = .systemGray5
        loginView.font = UIFont.preferredFont(forTextStyle: .title1)
        loginView.layer.cornerRadius = 6
        loginView.placeholder = "•••••••"
        
        shakeButton.addTarget(self, action: #selector(shakeTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(loginView)
        view.addSubview(shakeButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            shakeButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            shakeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func shakeTapped(_ sender: UIButton) {
        animate()
    }
}

// MARK: - Animations

extension ShakeViewController {

    func animate() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        loginView.layer.add(animation, forKey: "shake")
    }
}
