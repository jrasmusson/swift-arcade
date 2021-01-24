//
//  CurvedViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-24.
//

import UIKit

class CurvedViewController: BaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Dramatic Shadow"

        let height = sv.bounds.height
        let width = sv.bounds.width
        
        let shadowRadius: CGFloat = 5
        sv.layer.shadowRadius = shadowRadius
        sv.layer.shadowOffset = CGSize(width: 0, height: 10)
        sv.layer.shadowOpacity = 0.5

        // how strong to make the curling effect
        let curveAmount: CGFloat = 20
        let shadowPath = UIBezierPath()

        // the top left and right edges match our view, indented by the shadow radius
        shadowPath.move(to: CGPoint(x: shadowRadius, y: 0))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: 0))

        // the bottom-right edge of our shadow should overshoot by the size of our curve
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius, y: height + curveAmount))

        // the bottom-left edge also overshoots by the size of our curve, but is added with a curve back up towards the view
        shadowPath.addCurve(to: CGPoint(x: shadowRadius, y: height + curveAmount),
                            controlPoint1: CGPoint(x: width, y: height - shadowRadius),
                            controlPoint2: CGPoint(x: 0, y: height - shadowRadius))
        sv.layer.shadowPath = shadowPath.cgPath
    }
}
