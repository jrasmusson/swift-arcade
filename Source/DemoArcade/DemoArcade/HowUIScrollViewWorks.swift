//
//  HowUIScrollViewWorks.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-01.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

/*
 You can change what a view shows by changing its `bounds`.
 This example shifts a view up by 100 points by changing its bounds origin.
 
 This is the basis of how `UIScrollView` works.
 
 */
class HowUIScrollViewWorks: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        let greenView = UIView(frame: CGRect(x: 150, y: 160, width: 150, height: 200))
        let blueView = UIView(frame: CGRect(x: 40, y: 400, width: 200, height: 150))
        let yellowView = UIView(frame: CGRect(x: 100, y: 600, width: 180, height: 150))

        redView.backgroundColor = .systemRed
        greenView.backgroundColor = .systemGreen
        blueView.backgroundColor = .systemBlue
        yellowView.backgroundColor = .systemYellow

        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        view.addSubview(yellowView)

        ///
        /// By changing the views bounds, we can change what the user sees.
        ///

        var bounds = view.bounds
        bounds.origin = CGPoint(x: 0, y: 100)
        view.bounds = bounds
    }
}
