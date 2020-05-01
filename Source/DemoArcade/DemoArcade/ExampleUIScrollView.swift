//
//  ExampleUIScrollView.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-01.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

/*
    This example show how a real `UIScrollView` works.
    
    You add your views.
    Set the `contentSize`.
    And voila! You're scrollin'.
 
 */

class ExampleUIScrollView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        let customScrollView = UIScrollView(frame: view.bounds)
        
        // magic here - adjust height to make scroll area bigger or smaller
        customScrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1000)

        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        let greenView = UIView(frame: CGRect(x: 150, y: 160, width: 150, height: 200))
        let blueView = UIView(frame: CGRect(x: 40, y: 400, width: 200, height: 150))
        let yellowView = UIView(frame: CGRect(x: 100, y: 600, width: 180, height: 150))

        redView.backgroundColor = .systemRed
        greenView.backgroundColor = .systemGreen
        blueView.backgroundColor = .systemBlue
        yellowView.backgroundColor = .systemYellow

        customScrollView.addSubview(redView)
        customScrollView.addSubview(greenView)
        customScrollView.addSubview(blueView)
        customScrollView.addSubview(yellowView)

        view = customScrollView
    }
}
