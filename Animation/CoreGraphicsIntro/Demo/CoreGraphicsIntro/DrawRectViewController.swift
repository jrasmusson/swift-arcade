//
//  DrawRectViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

class DrawRectViewController: UIViewController {
    
    let drawRectView = DrawRectView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "drawRect gives you full control over how a layer will render. This view is 200 x 100. But the drawRect method on the inner view is a 100x100 red square. This shows how drawRect will only draw when you tell it - despite how big the container view is containing it."
        
        view.addSubview(drawRectView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            drawRectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drawRectView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            drawRectView.widthAnchor.constraint(equalToConstant: 200),
            drawRectView.heightAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalToSystemSpacingBelow: drawRectView.bottomAnchor, multiplier: 2),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 2),
        ])
    }
}
