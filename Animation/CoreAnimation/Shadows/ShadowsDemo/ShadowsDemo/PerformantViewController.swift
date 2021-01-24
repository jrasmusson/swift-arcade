//
//  PerformantShadowViewController.swift
//  ShadowsDemo
//
//  Created by jrasmusson on 2021-01-23.
//

import UIKit

/*
 Shadows are expensive. But we can make them more performant by:
 
   1. Rasterizing them (create a bitmap cache).
   2. Assigning them an explicit path.
 
 Note: To create a path based on the views bounds we need the view to be sized.
       For that reason we have to add shadows in `viewWillAppear` (not `viewDidLoad`).
 
 If you have a custom view you could also add the shadows for it in `layoutSubviews`.
 */
class PerformantViewController: UIViewController {
    
    let shadowView = UIView()
    let myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Performant Shadow"
        
        shadowView.backgroundColor = .systemRed
        shadowView.translatesAutoresizingMaskIntoConstraints = false

        myView.backgroundColor = .systemBlue
        myView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(shadowView)
        view.addSubview(myView)
        
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shadowView.widthAnchor.constraint(equalToConstant: 300),
            shadowView.heightAnchor.constraint(equalToConstant: 200),
            
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.topAnchor.constraint(equalToSystemSpacingBelow: shadowView.bottomAnchor, multiplier: 3),
            myView.widthAnchor.constraint(equalToConstant: 300),
            myView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shouldRasterize = true
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        // for performance...
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
    }
    
    class MyView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: 200, height: 200)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // do shadow work here once size is known
            addShadow()
        }
        
        func addShadow() {
            layer.shadowOpacity = 0.5
            layer.shouldRasterize = true
            layer.shadowOffset = CGSize(width: 5, height: 5)
            layer.rasterizationScale = UIScreen.main.scale
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
}
