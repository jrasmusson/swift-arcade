//
//  FlyViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-17.
//

import UIKit

// Hardcoded for iPad Pro (12.9 Inch) 1024 x 1366

class FlyViewController: UIViewController {
    
    lazy var worldView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 1024/2 - 256/2, y: 1366/2 - 256/2, width: 256, height: 256))
        view.image = UIImage(named: "world")

        return view
    }()

    lazy var shipView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 1024/4, y: 1366/2, width: 75, height: 90))
        view.image = UIImage(named: "ship")
        
        return view
    }()

    lazy var redBox: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 1024/2 - 20/2, y: 1366/2 - 20/2, width: 20, height: 20))
        view.backgroundColor = .systemRed
        
        return view
    }()
    
    lazy var redCircle: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 1024/2-300/2, y: 1366/2-300/2, width: 300, height: 300))
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        animate()
        animateRedBox()
        drawCircle()
    }
}

// MARK: - Setup

extension FlyViewController {
    
    func setup() {
        view.addSubview(redCircle)
//        view.addSubview(worldView)
//        view.addSubview(shipView)
        view.addSubview(redBox)
    }
}

// MARK: - Animations

extension FlyViewController {
    
    func animate() {
        let boundingRect = CGRect(x: 75/2, y: -256, width: 400, height: 400)
//        let boundingRect = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 4
        orbit.isAdditive = true
        orbit.repeatCount = HUGE
        orbit.calculationMode = CAAnimationCalculationMode.paced;
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto;

        shipView.layer.add(orbit, forKey: "orbit")
    }
    
    func animateRedBox() {
        let boundingRect = CGRect(x: -150, y: -150, width: 300, height: 300)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 0.1
        orbit.isAdditive = true
        orbit.repeatCount = HUGE
        orbit.calculationMode = CAAnimationCalculationMode.paced;
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto;

        redBox.layer.add(orbit, forKey: "redbox")
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 300, height: 300).insetBy(dx: 5, dy: 5) // line width 10

            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        redCircle.image = img
    }
}
