//
//  RotateViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-19.
//

import UIKit

class Rotate2ViewController: UIViewController {
    
    lazy var redBox: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 1024/2 - 40/2, y: 1366/2 - 40/2, width: 40, height: 40))
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
        animate()
        drawCircle()
    }
}

// MARK: - Setup

extension Rotate2ViewController {
    
    func setup() {
        view.addSubview(redCircle)
        view.addSubview(redBox)
    }
}

// MARK: - Animations

extension Rotate2ViewController {
        
    func animate() {
        let boundingRect = CGRect(x: -150, y: -150, width: 300, height: 300)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 2
        orbit.isAdditive = true
        orbit.repeatCount = HUGE
        orbit.calculationMode = CAAnimationCalculationMode.paced;
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto;

        redBox.layer.add(orbit, forKey: "redbox")
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 300, height: 300)

            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setLineWidth(1)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        redCircle.image = img
    }
}

