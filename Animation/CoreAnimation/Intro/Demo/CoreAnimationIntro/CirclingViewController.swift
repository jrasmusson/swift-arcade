//
//  CirclingViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-28.
//

import UIKit

class CirclingViewController: UIViewController {

    let redView = UIView()
    let _width: CGFloat = 40
    let _height: CGFloat = 40
    
    let redCircle = UIImageView()
    let _diameter: CGFloat = 300
    
    let button = makeButton(withText: "Animate")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.backgroundColor = .systemRed
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        
        view.addSubview(redView)
        view.addSubview(redCircle)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 2),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // draw box
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)

        // Demo purposes
//        redView.frame = CGRect(x: view.bounds.midX,
//                               y: view.bounds.midY,
//                               width: _width, height: _height)

        // draw circle
        redCircle.frame = CGRect(x: view.bounds.midX - _diameter/2,
                               y: view.bounds.midY - _diameter/2,
                               width: _diameter, height: _diameter)

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: _diameter, height: _diameter))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: _diameter, height: _diameter)

            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            ctx.cgContext.setLineWidth(1)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        redCircle.image = img
    }
    
    func animate() {
        
        let boundingRect = CGRect(x: -_diameter/2, y: -_diameter/2, width: _diameter, height: _diameter)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        
        
        orbit.duration = 2
        orbit.isAdditive = true
//        orbit.repeatCount = HUGE
        orbit.calculationMode = CAAnimationCalculationMode.paced;
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto;

        redView.layer.add(orbit, forKey: "redbox")
    }

    @objc func buttonTapped(_ sender: UIButton) {
        animate()
    }
}

