//
//  ViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-16.
//

import UIKit

class ViewController: UIViewController {
    
    let redoButton = makeButton(withText: "Redo")
    
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

extension ViewController {
    func setup() {
        redoButton.addTarget(self, action: #selector(redoTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(donkeyView)
        view.addSubview(marioView)
        view.addSubview(barrelView)
        view.addSubview(redoButton)
        
        // print(UIScreen.main.bounds.size)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            redoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            redoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func animate() {
        let barrelAnimation = CABasicAnimation()
        barrelAnimation.keyPath = "position.x"
        barrelAnimation.fromValue = 550
        barrelAnimation.toValue = 700
        barrelAnimation.duration = 1
        
        barrelView.layer.add(barrelAnimation, forKey: "basic")
        
        // update model to reflect final position of presentation layer
        barrelView.layer.position = CGPoint(x: 700, y: 330)
    }
    
    @objc func redoTapped(_ sender: UIButton) {
        animate()
    }
}


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
