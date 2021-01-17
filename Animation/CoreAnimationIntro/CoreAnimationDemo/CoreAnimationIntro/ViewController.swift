//
//  ViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-16.
//

import UIKit

class ViewController: UIViewController {
    
    let loginView = UITextField()
    
    let slideButton = makeButton(withText: "Slide barrel")
    let shakeButton = makeButton(withText: "Shake")
    
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
        animateBarrel()
    }
}

// MARK: - Setup

extension ViewController {
    
    func setup() {
        let lockImageView = UIImageView(image: UIImage(systemName: "lock"))
        loginView.leftViewMode = .always
        loginView.leftView = lockImageView

        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.backgroundColor = .systemGray5
        loginView.font = UIFont.preferredFont(forTextStyle: .title1)
        loginView.layer.cornerRadius = 6
        loginView.placeholder = "•••••••"
        
        slideButton.addTarget(self, action: #selector(slideTapped(_:)), for: .primaryActionTriggered)
        shakeButton.addTarget(self, action: #selector(shakeTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(donkeyView)
        view.addSubview(marioView)
        view.addSubview(barrelView)

        view.addSubview(loginView)

        view.addSubview(slideButton)
        view.addSubview(shakeButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            slideButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            slideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginView.topAnchor.constraint(equalTo: slideButton.bottomAnchor, constant: 60),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            shakeButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            shakeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func slideTapped(_ sender: UIButton) {
        animateBarrel()
    }
    
    @objc func shakeTapped(_ sender: UIButton) {
        shakeLogin()
    }

}

// MARK: - Animations

extension ViewController {

    func animateBarrel() {
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 550
        animation.toValue = 700
        animation.duration = 1
        
        barrelView.layer.add(animation, forKey: "basic")
        
        // update model to reflect final position of presentation layer
        barrelView.layer.position = CGPoint(x: 700, y: 330)
    }

    func shakeLogin() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        loginView.layer.add(animation, forKey: "shake")
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
