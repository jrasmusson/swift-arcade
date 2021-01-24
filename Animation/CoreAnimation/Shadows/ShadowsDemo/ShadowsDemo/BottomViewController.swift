//
//  ContactShadowViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-23.
//

import UIKit

class BottomViewController: BaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Contact Shadow"

        let shadowSize: CGFloat = 20
        let height = sv.bounds.height
        let width = sv.bounds.width
        
        let contactRect = CGRect(x: -shadowSize,
                                 y: height - (shadowSize * 0.4),
                                 width: width + shadowSize * 2,
                                 height: shadowSize)

        sv.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        sv.layer.shadowRadius = 5
        sv.layer.shadowOpacity = 0.4
    }
}
