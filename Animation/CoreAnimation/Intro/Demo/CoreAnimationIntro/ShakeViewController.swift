//
//  ShakeViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-17.
//

import UIKit

class ShakeViewController: UIViewController {
    
    let textField = UITextField()
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
        textField.setIcon(UIImage(systemName: "lock")!)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.font = UIFont.preferredFont(forTextStyle: .title1)
        textField.layer.cornerRadius = 6
        textField.placeholder = "  •••••  "
        
        shakeButton.addTarget(self, action: #selector(shakeTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(textField)
        view.addSubview(shakeButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            shakeButton.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 2),
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
        textField.layer.add(animation, forKey: "shake")
    }
}

extension UITextField {
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
