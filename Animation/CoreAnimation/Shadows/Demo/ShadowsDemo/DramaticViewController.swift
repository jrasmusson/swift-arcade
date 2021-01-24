//
//  TramaticViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-24.
//

import UIKit

class DramaticViewController: BaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Dramatic Shadow"

        let height = sv.bounds.height
        let width = sv.bounds.width
        
        sv.layer.shadowRadius = 0
        sv.layer.shadowOffset = .zero
        sv.layer.shadowOpacity = 0.2

        // how far the bottom of the shadow should be offset
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: height))
        shadowPath.addLine(to: CGPoint(x: width, y: height))

        // make the bottom of the shadow finish a long way away, and pushed by our X offset
        shadowPath.addLine(to: CGPoint(x: width + 2000, y: 2000))
        shadowPath.addLine(to: CGPoint(x: 2000, y: 2000))
        sv.layer.shadowPath = shadowPath.cgPath

        view.backgroundColor = .systemOrange
    }
}

