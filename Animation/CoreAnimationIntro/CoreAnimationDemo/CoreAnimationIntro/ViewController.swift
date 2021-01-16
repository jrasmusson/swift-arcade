//
//  ViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-16.
//

import UIKit

class ViewController: UIViewController {
    
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
        let view = UIImageView(frame: CGRect(x: 500, y: 300, width: 98, height: 61))
        view.image = UIImage(named: "barrel")
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        animate()
    }
}

extension ViewController {
    func setup() {
        view.addSubview(donkeyView)
        view.addSubview(marioView)
        view.addSubview(barrelView)
        
        // print(UIScreen.main.bounds.size)
    }
    
    func animate() {
        let barrelAnimation = CABasicAnimation()
        barrelAnimation.keyPath = "position.x"
        barrelAnimation.fromValue = 500
        barrelAnimation.toValue = 700
        barrelAnimation.duration = 1
        
        barrelView.layer.add(barrelAnimation, forKey: "basic")
        
        // update model to reflect final position of presentation layer
        barrelView.layer.position = CGPoint(x: 700, y: 300)
    }
}
