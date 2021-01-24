//
//  FrontShadowViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-24.
//

import UIKit

class FrontViewController: BaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Front Shadow"

        let height = sv.bounds.height
        let width = sv.bounds.width
        
        // how wide and high the shadow should be, where 1.0 is identical to the view
        let shadowWidth: CGFloat = 1.20
        let shadowHeight: CGFloat = 0.5

        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: height))
        shadowPath.addLine(to: CGPoint(x: width, y: height))
        shadowPath.addLine(to: CGPoint(x: width * shadowWidth, y: height + (height * shadowHeight)))
        shadowPath.addLine(to: CGPoint(x: width * -(shadowWidth - 1), y: height + (height * shadowHeight)))
        
        sv.layer.shadowPath = shadowPath.cgPath
        sv.layer.shadowRadius = 5
        sv.layer.shadowOffset = .zero
        sv.layer.shadowOpacity = 0.2
    }
}

